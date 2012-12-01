### Requires ###################################################################
require 'resolv'
require 'pony'
################################################################################
### Functions ##################################################################
# Heuristic for killing results that are not useful.
def heuristicFilter(results, str)
	# Get into manageable form
	results.delete_if do |v|
		b = true
		strings = v['value'].split
		strings.each do |str2|
			if !((str.subsequence(str2).to_f/str2.length.to_f)<0.66)
				b = false
				break
			end
		end
		b
	end
end
# Get ICIDs from the results.
def getICIDsFromResults(results)
	seen = []
	results.each do |row|
		if !seen.include?(row["icid"])
			seen << row["icid"]
		end
	end
	return seen
end
def countUniqueProducts(results)
	count = 0
	seen = []
	results.each do |row|
		if !seen.include?(row["pid"])
			seen << row["pid"]
			count+=1
		end
	end
	return count
end
# Return an array of integers, signalling which question priority to skip to.
def processSkipHint(skiphint)
	if !skiphint.kind_of?(String)
		return nil
	else
		return skiphint.split('|').map{|item| item.to_i}
	end
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
Actions << Hash[:description, "Identify products", :priority, 10,
		:configurable, true, :code,
lambda { |idents, user|

tasklist = user.tasks
info = user.nextTask.info

# Queries we will reference several times throughout procedure.
countq = "SELECT DISTINCT pid FROM productidentifiers"
heuristicq = "SELECT DISTINCT pid, icid, value FROM productidentifiers"
geticidsq = "SELECT DISTINCT icid FROM productidentifiers WHERE "+
		"pid IN ( "

# Some initial setup
if info[:pids] == nil
	info[:pids] = ConfigDB.execute(countq)
	info[:pids] = info[:pids].each_index do |i|
		info[:pids][i] = info[:pids][i]["pid"]
	end
	# Get the questions to ask.
	info[:toask] = Hash.new
	IdentCats.each do |row|
		info[:toask][row["id"].to_i] = row["name"]
	end
	info[:prevq] = 0
end

info[:prevqmatched] = false

# First remove all things that never make sense if this is special question.
if info[:prevqname] != nil and
   IdentCats.select{|row| row["name"] == info[:prevqname]}[0]["priority"] < 1
	
	todelete = []
	# Try and find an ident to satisfy this question.
	idents.each do |ident|
		results = ConfigDB.execute("SELECT Q.value, Q.answer "+
				"FROM identifiercategories I, questionpath Q "+
				"WHERE I.name = ? and I.id = Q.key",
					info[:prevqname])
		results.each do |row|
			if md = ident.match(/^#{row["answer"]}/i)
				todelete << ident
				info[:toask].delete(row["value"].to_i)
			end
		end
	end
	
	# Delete idents no longer needed.
	todelete.each{|d| idents.delete(d)}
	
	# Remove the question, move on.
	info[:toask].delete_if{|k, v| v == info[:prevqname]}
end

# We will store the results of a query here.
results2 = nil

# Have variable to track number of products identified.
count1 = 0	# Count with previous query.
count2 = 0	# Count with new proposed query.

# Eliminate question if we have an identifier for it, and construct new query
idents.each do |e|
	# First get an initial count from last query
	count1 = info[:pids].length
	
	results2 = ConfigDB.execute(heuristicq + " WHERE (icid=? AND "+
					"value LIKE ?)",
					info[:prevq], '%'+e+'%')
	heuristicFilter(results2, e)
	
	if results2.length > 0
		results2 = ConfigDB.execute(countq+
			" WHERE (icid=? AND value LIKE ?)", info[:prevq],
						'%'+e+'%')	
		results2 = results2.each_index do |i|
			results2[i] = results2[i]["pid"]
		end
		results2 = info[:pids] & results2
		count2 = results2.length
	end
	
	if count1 - count2 > 0 and count2 > 0
		# Delete previous question from toask list if its not 'option'
		# TODO: Make this more efficient?
		info[:toask].delete_if do |k, v|
			info[:prevq]==k && v != "option"
		end
		info[:pids] = results2
		
		# Set flag to remove previous question.
		info[:prevqmatched] = true
		
		# Remove all occurences values from idents.
		#idents.delete(e)
		break
	end
end

count2 = 0
# Now we will attempt to match any other words with whatever we can
idents.each do |e|
	# First get an initial count from last query
	count1 = info[:pids].length
	
	results2 = ConfigDB.execute(heuristicq + " WHERE (icid!=? AND "+
					"value LIKE ?)",
					info[:prevq], '%'+e+'%')
	heuristicFilter(results2, e)
	icids = getICIDsFromResults(results2)
	
	#####
	newquery = String.new(countq) + " WHERE (value LIKE ? AND "	
	newquery << "icid IN (" + icids.join(", ") + ")"
	newquery << ")"	
	#####
	
	# Execute the new query.
	results2 = ConfigDB.execute(newquery, '%'+e+'%')	
	results2 = results2.each_index do |i|
		results2[i] = results2[i]["pid"]
	end
	results2 = info[:pids] & results2
	count2 = results2.length
	
	if count1 - count2 > 0 and count2 > 0
		info[:pids] = results2
		
		# Remove all occurences values from idents.
		#idents.delete(e)
	end
end

=begin
=end
### Eliminate all questions that no longer make sense.
# First we will eliminate all questions that have no answers left.
eliminator = ConfigDB.execute(geticidsq + info[:pids].join(", ")+")")
eliminator.each_index{|i| eliminator[i] = eliminator[i]["icid"]}
p "eliminator #{eliminator}"
p "query #{info[:pids]}"
if info[:prevq] != 0 and info[:prevqmatched]
	eliminator.delete(info[:prevq])
end
info[:toask].each do |k, v|
	if eliminator.include?(k) or
	   IdentCats.select{|row| row["id"] == k}[0]["priority"].to_i < 1
		# These are the things we keep.
	else
		info[:toask].delete(k)
	end
end
# Next we will eliminate all questions that have the same answer.
info[:toask].delete_if do |k, v|
	count = ConfigDB.execute("SELECT COUNT(DISTINCT value) as count FROM "+
				"productidentifiers WHERE icid = ? AND "+
				"pid IN (" + info[:pids].join(", ") + ")",
				k)[0]["count"]
	if count <= 1 and 
	   IdentCats.select{|row| row["id"] == k}[0]["priority"].to_i >= 1
		true
	else
		false
	end
end

# If the product has been identified, return it.
if 1 == count1 or 1 == count2 or info[:toask].length == 0
	info[:results] = info[:pids]
	# Add list task
	newtask = Task.new(2, Actions[2][:priority], 2)
	user.addTask(newtask)
	return nil, 2
end

# Choose the next question
# Find highest priority item that is not of normal priority.
minPriorityItem = nil
info[:toask].keys.each do |key|
	# We are guaranteed to get 1 result, so this is cool.
	category = IdentCats.select{|row| row["id"] == key}[0]
	
	if minPriorityItem == nil or
	   category["priority"].to_i < minPriorityItem["priority"].to_i
		minPriorityItem = category
	end
end
if minPriorityItem["priority"].to_i < 1
	nextq = minPriorityItem["id"].to_i
else
	until nextq!=nil and (nextq != info[:prevq] or info[:toask].length < 2)
		nextq = info[:toask].keys.sample
	end
end

# Setup previous information for next request
info[:prevqname] = (IdentCats.select { |x| x['id'] == nextq })[0]['name']
info[:prevq] = nextq
# Return the question
question = ConfigDB.execute("SELECT question FROM identifierquestions "+
				"WHERE icid = ?", nextq).sample["question"]
return question, 1
}]

=begin
Termination of highest priority level task.
=end
Actions << Hash[:description, "End immediate task", :priority, -100,
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
Actions << Hash[:description, "Show results", :priority, -100,
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

pids = info[:pids]

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
Actions << Hash[:description, "Choose products from list", :priority, -101,
		:configurable, false, :code,
lambda { |idents, user|

info = user.nextTask.info

lastqty = 1
notsatisfied = []
idents.each do |newident|
	# If this string represents an item...
	md = newident.match(/^p([0-9]*)$/i)
	if md != nil and (md[1] =~ /^[-+]?[0-9]+$/ or md[0].kind_of?(Integer))
		key = md[0][1..-1].to_i
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
Actions << Hash[:description, "Enter order information", :priority, 100,
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
Actions << Hash[:description, "Confirm order", :priority, -1000,
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

=begin
Display help information
=end
Actions << Hash[:description, "Display Help Information", :priority, -10000,
		:configurable, true, :code,
lambda { |idents, user|

helpMessage = ""

# Talk about basic information
helpMessage << "You can make me do the following actions by including one of "+
		"these words in your message:"
aid = 0
Actions.each do |action|
	if action[:configurable]
		helpMessage << "\\n\\t#{action[:description]}"
		ConfigDB.execute("SELECT * FROM actionphrases WHERE aid=?",
				aid).each do |row|
			helpMessage << "\\n\\t\\t"+row["phrase"]
		end
	end
	aid+=1
end

# Remove this task
user.tasks.shift

return helpMessage, 1

}]

=begin
Report user UID so they can resume the session later.
=end
Actions << Hash[:description, "Report Session ID", :priority, -10000,
		:configurable, true, :code,
lambda { |idents, user|
	# TODO: Add security measure?!?
	
	# Get rid of this task.
	user.tasks.shift
	
	# Choose a message from a random set.
	message = [
				"Your session identification number is _.",
				"_ is your session identification number.",
				"Alright, your session ID is _."
		  ].sample
	
	# Substitute in the users id.
	message.gsub!(/_/, user.id.to_s)
	
	return message, 1
}]

=begin
Resume a previous session.
=end
Actions << Hash[:description, "Resume previous session", :priority, -1000000,
		:configurable, true, :code,
lambda { |idents, user|
	# Shift off this task.
	user.tasks.shift
	
	# Search all the idents for the first UID that works.
	idents.each do |ident|
		newuser = UserStoreDB.execute("SELECT serialized FROM "+
						"userstore WHERE uid = ?;",
						ident)
		if newuser.length == 1
			newuser = YAML.load(newuser[0]['serialized'])
			return "Sucessfully loaded session session.", 2, newuser
		end
	end
	return "I'm sorry, I couldn't find a matching session.", 2
}]
################################################################################
