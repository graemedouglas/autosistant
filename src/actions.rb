### Requires ###################################################################
require 'resolv'
require 'pony'
################################################################################

### Functions ##################################################################
# Return an array of integers, signalling which question priority to skip to.
def processSkipHint(skiphint)
	if !skiphint.kind_of?(String)
		return nil
	else
		return skiphint.split('|').map{|item| item.to_i}
	end
end
# Validate email address.  Taken from: http://www.buildingwebapps.com/articles/79182-validating-email-addresses-with-ruby
def validate_email_domain(email)
      domain = email.match(/\@(.+)/)[1]
      Resolv::DNS.open do |dns|
          @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      end
      @mx.size > 0 ? true : false
end
################################################################################

### Actions ####################################################################
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
Actions << Hash[:description, "Identify products.", :priority, 10,
		:configurable, true, :code,
lambda { |idents, user|
## TODO's
#   Make it so the user can stop process and choose identified results

tasklist = user.tasks
info = user.nextTask.info

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
geticidsq = "SELECT DISTINCT icid FROM productidentifiers"
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
	count2 = ConfigDB.execute(countq + info[:querypred] +
		" AND (icid = ? AND value = ?)", info[:prevq], e)[0]["count"]
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

# Eliminate all questions that no longer make sense.
eliminator = ConfigDB.execute(geticidsq + info[:querypred])
eliminator.each_index {|i| eliminator[i].delete_if {|k, v| k.kind_of?(Integer)}}
eliminator.each_index {|i| eliminator[i] = eliminator[i].flatten}
eliminator = eliminator.flatten
eliminator.delete("icid")
info[:toask].each do |k, v|
	if eliminator.include?(k)
	else
		info[:toask].delete(k)
	end
end

# If the product has been identified, return it.
if 1 == count1 or 1 == count2 or info[:toask].length == 0
	info[:results] = ConfigDB.execute(getidsq + info[:querypred])
	# Add list task
	newtask = Task.new(2, Actions[2][:priority], 2)
	user.addTask(newtask)
	return nil, 2
end

# Choose the next question
# TODO: ONLY TAKE RANDOM IF CONFIG SAYS TO!
nextq = info[:toask].keys.sample

# Setup previous information for next request
info[:prevqname] = (IdentCats.select { |x| x['id'] == nextq })[0]['name']
# Return the question
return (IdentCats.select { |row| row["id"] == nextq })[0]["question"], 1
}]

=begin
Termination of highest priority level task.
=end
Actions << Hash[:description, "End immediate task.", :priority, -100,
		:configurable, true,
		:code,
lambda { |idents, user|
# Remove this task and the task we intend to get rid of.
2.times { user.tasks.shift }
# Return looping signal
return nil, 2
}]

=begin
Show results of current search.
=end
Actions << Hash[:description, "Show results.", :priority, -100,
		:configurable, true, :code,
lambda { |idents, user|

tasklist = user.tasks
info = user.nextTask.info

# Remove this task.
tasklist.shift

# Erroneous if there is nothing to get rid of.
# TODO Get rid of these stupid magic numbers!
# TODO If I ever use tasks with lists for items, I need to recursively get item
if tasklist.first == nil or tasklist.first.item != 0
	return "There is nothing to list.", 2
end

# Get the next task's info.
info = tasklist[0].info

# The query to get all of the product ids
getpidsq = "SELECT DISTINCT pid FROM productidentifiers"
getproductsq = "SELECT * FROM product WHERE id = ?"

pids = ConfigDB.execute(getpidsq + info[:querypred])
pids.each_index { |i| pids[i].delete_if {|k, v| k.kind_of?(Integer)} }
pids.each_index { |i| pids[i] = pids[i].flatten }
pids = pids.flatten
pids.delete("pid")

toask = "These are the products I have identified:\\n"

# Build up return string
pids.length.times do |i|
	row = ProductDB.execute(getproductsq, pids[i])[0]
	next if row == nil
	toask << "\\tp" + i.to_s + ":\\t " + row["name"] + ". In stock: "+
			row["qty"].to_s + ". Price: "+
			"$#{'%.2f'%(row["price"].to_f/100)}\\n"
end
toask << "Which item(s) would you like to add to the order?"

# Build up action that allows user to choose products from list.
# TODO Get rid of magic numbers, if possible.
newtask = Task.new(3, Actions[3][:priority], 3)
newtask.info[:pids] = pids

# Pop off identification task, pop on new task
tasklist.shift
user.addTask(newtask)

return toask, 1
}]

=begin
Choose items from a selection.  Desired items must be chosen with the quantity
before the item.  Items must take the form p<number>.
=end
Actions << Hash[:description, "Choose products from list.", :priority, -101,
		:configurable, false, :code,
lambda { |idents, user|

info = user.nextTask.info

lastqty = 1
notsatisfied = []
idents.each do |newident|
	# If this string represents an item...
	md = newident.match(/^p([0-9]*)$/i)
	if md != nil and (md[1] =~ /^[-+]?[0-9]+$/ or md[0].kind_of?(Integer))
		key = md[0].to_i
		pid = info[:pids].delete_at(key)
		
		UpdateQuantity.synchronize {
			# Check if we can satisfy quantity entered.
			qtyr=ProductDB.execute("SELECT qty FROM product "+
						"WHERE id = ?",
						pid)
			if qtyr != nil && qtyr.length > 0
				# Get the quantity left.
				qty = qtyr[0]["qty"]
				
				if qty < lastqty
					notsatisfied << [key, pid]
				else
					qty-=lastqty
					# We actually want to do the update on
					# order placement... still to do.
					#ProductDB.execute("UPDATE product SET"+
					#		" qty = ? WHERE id = ?",
					#		qty, pid)
					user.updateOrder(pid, lastqty)
					lastqty = 1
				end
			end
		}
	# If this string strictly represents an integer...
	elsif newident =~ /^[-+]?[0-9]+$/
		lastqty = newident.to_i
		# TODO What if the user wants to delete items from order?!?
		if lastqty < 1 then lastqty = 0 end
	end
end

# Build up return message.
toRet = nil
if notsatisfied.length > 0
	toRet = "The following items could not be added to the order:"
	notsatisfied.each do |item|
		toRet << "\\n\\tp"+item[0].to_s
	end
end

# Remove this task
user.tasks.shift
newtask = Task.new(4, Actions[4][:priority], 4)
user.addTask(newtask)
return toRet, 2
}]

=begin
Show the order information.
=end
Actions << Hash[:description, "Display order info", :priority, -102,
		:configurable, true, :code,
lambda { |idents, user|
# Check if there are any products in the order.
if user.emptyOrder?
	# Remove this tasks
	user.tasks.shift
	
	return "You currently have no items in your order.", 2
end

# Queries we will reference
getproductq = "SELECT * FROM product WHERE id = ?"
newmessage = "Your current order includes:"
user.toBuy.each_pair do |k, v|
	product = ProductDB.execute(getproductq, k)[0]
	# TODO: make currency marker configurable.
	newmessage << "\\n\\t Price: $#{'%.2f'%(product["price"].to_f/100)}. "+
			"Product: #{product["name"]}. Quantity: #{v}"
end

# Pop off this task, as it is complete
user.tasks.shift

return newmessage, 2
}]

=begin
Enter order information.
=end
Actions << Hash[:description, "Enter order information.", :priority, 100,
		:configurable, true, :code,
lambda { |idents, user|
# Get the task information.
info = user.nextTask.info

# If first time executing this task...
if info[:toask] == nil
	# Check to see if there anything to order.
	if user.toBuy.empty?
		user.tasks.shift
		return "There isn't anything to order!", 2
	elsif user.info[:orderinfo] != nil
		return "Something very bad is happening...", 2
	end
	
	# Create the hash for the order information
	info[:orderinfo] = Hash.new
	
	# Create an empty list for questions.
	info[:toask] = []
	
	# Get all of the questions to ask, choose one of each type at random
	questions = ConfigDB.execute("SELECT * FROM orderquestions "+
		"ORDER BY priority ASC")
	samequestions = nil
	questions.each do |row|
		# If there is nothing in same questions, add row to it.
		if samequestions == nil
			row["skiphint"]=processSkipHint(row["skiphint"])
			samequestions = [row]
		# If new row has same priority, add it to array.
		elsif samequestions[0]["priority"] == row["priority"]
			row["skiphint"]=processSkipHint(row["skiphint"])
			samequestions << row
		# Otherwise we need to choose a question randomly.
		elsif samequestions[0]["priority"] < row["priority"]
			info[:toask] << samequestions.sample
			row["skiphint"]=processSkipHint(row["skiphint"])
			samequestions = [row]
		end
	end
	if samequestions != nil and !samequestions.empty?
		info[:toask] << samequestions.sample
	end
	
	# Ask next question.
	return info[:toask].first["question"], 1
end

# Verify last answer
newmessage = nil
idents.each do |ident|
	# TODO: Decide whether I should add ^..$ to the regex.
		# Month regex becomes a nightmare if I do...
	if info[:toask].first["regex"] == '' or
			md = ident.match(/^#{info[:toask].first["regex"]}/i)
		newmessage = ""
		
		# Get the label from the question.
		label = info[:toask].first["label"].to_sym
		
		# Determine which part of regex it matched.
		if md != nil
			whichregex = md.to_a[1..-1].find_index{|x| x != nil}
		else
			whichregex = 0
		end
		
		# Skip ahead to next question.
		if info[:toask].first["skiphint"].length == 1
			skiphint = info[:toask].first["skiphint"][0]
		else
			skiphint = info[:toask].first["skiphint"][whichregex]
		end
		info[:toask].shift
		while !info[:toask].empty? and
				skiphint > (info[:toask].first)["priority"]
			info[:toask].shift
		end
		
		# Store new information.
		info[:orderinfo][label] = ident
		
		# Break out.
		break
	end
end
if newmessage == nil
	newmessage = "Your answer didn't make sense.  Lets try this again."+
			"\\n\\n"
end

# If more questions, ask next question.  Otherwise, confirm and place order.
if info[:toask].empty?
	# Remove this item off the task list.
	user.tasks.shift
	
	# TODO: Change all Task.new to not need id.  This is stupid
	newtask = Task.new(6, Actions[6][:priority], 6)
	newtask.info[:first] = true
	newtask.info[:orderinfo] = info[:orderinfo]
	user.addTask(newtask)
	return nil, 2
else
	return newmessage + info[:toask].first["question"], 1
end
}]


=begin
Confirm order information
=end
Actions << Hash[:description, "Confirm order.", :priority, -1000,
		:configurable, false, :code,
lambda { |idents, user|
# Look for yes/no response.
if idents == nil or idents.empty?
	return "Are you sure you want to place this order?", 1
end

idents.each do |ident|
	if ident =~ /yes|y/i
		# Add product information.
		user.tasks.first.info[:orderinfo][:products] = user.toBuy
		
		# Add order to database.
		ConfigDB.execute("INSERT INTO stagedorders(orderinfo)"+
					" VALUES (?)",
					user.info[:orderinfo].to_yaml)
		
		# Remove order information.
		user.toBuy = Hash.new
		
=begin
		# Send an email
		Pony.mail(:to => user.tasks.first.info[:orderinfo][:email],
				:from => NoreplyEmail,
				:subject => "Your Order from #{CompanyName}",
				:body => OrderNotification)
=end
		
		# Remove this task.
		user.tasks.shift
		
		# Return message.
		return "Your order was placed successfully. "+
				"You will receive a confirmation "+
				"email shortly.", 2
	elsif ident =~ /no|n/i
		# Delete order information.
		user.info[:orderinfo] = nil
		
		# Remove this task.
		user.tasks.shift
		
		# Return message.
		return "Your order information has been deleted.", 2
	end
end

# Return message again asking for confirmation.
if user.tasks.first.info[:first] == true
	user.tasks.first.info[:first] = nil
	return "Are you sure you want to place this order?", 1
end
return "I'm sorry, I was unable to determine your decision.\\n\\n"+
		"Are you sure you want to place this order?", 1
}]
################################################################################
