# Actions to be executed by the system.  These eventually need to end up in DB

# Create an array to store all procs in.
Actions = []

=begin
The goal of this task is to match identifiers to remaining questions by first
attempting to match new identifiers to the current question, by attempting
to match identifiers in the order they appeared in the user input.  If a match
is found for the previously asked question, we terminate that search and
remove both the question and the answer from their respective arrays.
Once we either run out of choices or terminate, we attempt to match the
remaining new identifiers on a first-come, first serve basis.
=end

Actions << Hash[:description, "Identify products.", :priority, 10, :code,
lambda { |idents, info|
## TODO's
#   Eliminate questions that no longer make sense.
#   Make it so the user can stop process and choose identified results

# Some initial setup
if info[:querypred] == nil
	info[:querypred] = " WHERE 1=1"
	# Get the questions to ask.
	info[:toask] = Hash.new
	IdentCats.each do |row|
		info[:toask][row["id"].to_i] = row["name"]
	end
	info[:prevq] = 0
end

# Queries we will reference several times throughout procedure.
countq = "SELECT COUNT(DISTINCT pid) AS count FROM productidentifiers"
questionq = "SELECT question FROM identifiercategories WHERE aid = ?"
getidsq = "SELECT DISTINCT pid FROM productidentifiers"

# Have variable to track number of products identified.
count1 = 0
count2 = 0

#require 'ruby-debug';debugger
# Eliminate question if we have an identifier for it, and construct new query
idents.each do |e|
	# First get an initial count from last query
	count1 = ConfigDB.execute(countq + info[:querypred])[0]["count"]
	# Get the positive difference.
	count2 = ConfigDB.execute(countq + info[:querypred] + " AND (icid = ? AND value = ?)",info[:prevq],e)[0]["count"]
	if count1 - count2 > 0 and count2 > 0
		# Delete previous question from toask list if its not 'option'
		# TODO: Make this more efficient?
		info[:toask].delete_if do |k, v|
			info[:prevq]==k && v != "option"
		end
		# TODO: Come up with a way to prevent SQL Injections
		info[:querypred] << " AND (icid = " + info[:toask][:prevq]
			+ " AND value = '" + e + "')"
		# Remove all occurences values from idents.
		idents.delete(e)
		break
	end
end

# Now we will attempt to match any other words with whatever we can
idents.each do |e|
	info[:toask].keys.each do |id|
		# First get the number of items we currently identify.
		count1 = ConfigDB.execute(countq +
			info[:querypred])[0]["count"]
		count2 = ConfigDB.execute(countq + info[:querypred] +
			" AND (icid = ? AND value = ?)", id, e)[0]["count"]
		# If we made any progress, pair them up, eliminate queries.
		if count1 - count2 > 0 and count2 > 0
			# TODO: Make this more efficient?
			info[:toask].delete_if do |k, v|
				k==id && v != "option"
			end
			# TODO: Prevent sql injections.
			info[:querypred] << " AND (icid = " + id.to_s +
				" AND value = '" + e + "')"
			# Remove all occurences value from new_idents.
			idents.delete(e)
			break
		end
	end
end

# If the product has been identified, return it.
if 1 == count1 or 1 == count2
	info[:results] = ConfigDB.execute(getidsq + info[:querypred])
	return 1
end

# Choose the next question
# TODO: ONLY TAKE RANDOM IF CONFIG SAYS TO!
if info[:toask].length == 0
	# Do end of task items.
	# Return number of next task to do.
	return 1
end
nextq = info[:toask].keys.sample

# Setup previous information for next request
info[:prevqname] = (IdentCats.select { |x| x['id'] == nextq })[0]['name']
# Return the question
(IdentCats.select { |row| row["id"] == nextq })[0]["question"]
}]
