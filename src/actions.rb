# Actions to be executed by the system.  These eventually need to end up in DB

# Create an array to store all procs in.
ActionProcs = []

=begin
The goal of this proc is to match identifiers to remaining questions by first
attempting to match new identifiers to the current question, by attempting
to match identifiers in the order they appeared in the user input.  If a match
is found for the previously asked question, we terminate that search and
remove both the question and the answer from their respective arrays.
Once we either run out of choices or terminate, we attempt to match the
remaining new identifiers on a first-come, first serve basis.
=end
ActionProcs << lambda |newidents| {
# Have variable to track number of products identified.
count = 0
# Eliminate question if we have an identifier for it, and construct new query
newidents.each |e| do
	# First get an initial count from last query
	count = ConfigDB.execute(info[:queries][:count])[0]["count"]
	# Get the positive difference.
	count -= ConfigDB.execute(info[:queries][:count] + " AND ? = ?;",
		info[:prevq_iname], e)[0]["count"]
	if count > 0
		# Delete previous question from toask list if its not 'option'
		# TODO: Make this more efficient?
		info[:toask].delete_if { |k, v| info[:toask][prevq_iname]==v &&
						v != "option" }
		info[:query] << " AND " info[:toask][prevq_iname] + " = " + 				newident
		# Remove all occurences value from new_idents.
		newsidents.delete_if { |v| v == e }
		break
	end
end

# Now we will attempt to match any other words with whatever we can
newidents.each |e| do
	info[:toask].each |q| do
		# First get the number of items we currently identify.
		count = ConfigDB.execute(info[:queries][:count])[0]["count"]
		# Got the positive difference with new query
		count -= ConfigDB.execute(info[:queries][:count]+" AND ? = ?;",
			q, e)[0]["count"]
		# If we made any progress, pair them up, eliminate queries.
		if count > 0
			# TODO: Make this more efficient?
			info[:toask].delete_if { |k, v|
						 info[:toask][prevq_iname] == v
						 && v != "option" }
			# TODO: Figure out a way to "prepare"?
			info[:query] << " AND " q + " = " + newident
			# Remove all occurences value from new_idents.
			newsidents.delete_if { |v| v == e }
		break
	end
end
# Choose the next question
# TODO: ONLY TAKE RANDOM IF CONFIG SAYS TO!
nextq = info[:toask].keys.sample
if nextq == nil
	# Do end of task items.
	# Return number of next task to do.
	return nil
end
# Setup previous information for next request
info[:prevq_iname] = (IdentCats.select { |x| x['id'] == nextq })[0]['name']
# Return the question
ConfigDB.execute("SELECT question FROM identifiercategories WHERE id = ?;",
	nextq)[0]['question']
end
}
