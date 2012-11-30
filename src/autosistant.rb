################################################################################
# Author:		Graeme Douglas
##
# The main execution script for the autosistant application.
################################################################################

### Requirements ###############################################################
require 'rubygems'		# For Ruby version < 1.9
require 'sinatra'		# Webframework to use
require 'yaml'			# Required for serializing objects.
require 'sqlite3'		# Require the database module we will use.
require 'json'			# Needed to parse json.
require './config.rb'		# System wide configuration options
require './classes.rb'		# Various classes and classmods needed.
require './actions.rb'		# System actions code.

if DEBUG_ON
	require 'shotgun'	# Restart server on each page refresh
end
################################################################################

### Helpers ####################################################################
helpers do
	include Rack::Utils
	alias_method :h, :escape_html
end
################################################################################

### Functions ##################################################################
# Levenshtein distance function, used for guessing size of strings.
# 	Taken from: https://github.com/gburtini/Go/blob/master/go.rb
def levenshtein(a, b, delc, addc, subc)
	back = nil, back2 = nil
	current = (1..b.size).to_a + [0]
	a.size.times do |x|
		# Shuffle previous three steps and create new one for this round
		back2, back, current = back, current, [0] * b.size + [x + 1]
		
		b.size.times do |y|
			# Compute the different ways we could get there.
			del = back[y] + delc
			add = current[y - 1] + addc
			sub = back[y - 1] + ((a[x] != b[y]) ? addc : 0)
			current[y] = [del, add, sub].min
			
			if (x > 0 &&
			    y > 0 &&
			    a[x] == b[y-1] &&
			    a[x-1] == b[y] &&
			    a[x] != b[y])
				current[y] = [current[y], back2[y-2] + 1].min
			end
		end
	end
	
	return current[b.size - 1]
end

# Make suggestions based on user input.
def makeSuggestions(words)
	# Suggestions list
	suggestions = []
	
	ActionPhrases.each do |row|
		words.each do |uword|
			aword = row['phrase']
			longest = [uword.length, aword.length].max
			edist = levenshtein(aword, uword, 1, 1, 1)
			score = (1 - (edist.to_f/longest.to_f))
			if score >= 0.66
				suggestions << aword
			end
		end
	end
	
	return nil if suggestions.empty?
	
	# Prepare message to return.
	toRet = "Nothing you said told me what to do.  Maybe you meant:"
	suggestions.each do |s|
		toRet << "\\n\\t"+s
	end
	toRet
end

# Process a message.
def processRequest(params)
	# Set a flag so that we execute the correct query later on.
	fromDB = false
	
	# Get the user id.
	uid = params[:uid]
	
	# Create or retrieve the user object.
	user = nil
	if uid == "-1"
		# Ensure we generate a unique uuid.
		result = nil
		until result == 0
			uid = SecureRandom.uuid
			result = UserStoreDB.execute("SELECT COUNT(*) as count"+
					" FROM userstore WHERE uid = ?;", uid)
			result = result[0]["count"]
		end
		
		# Must create new user object.
		user = User.new(uid)
		result = 1
	else
		# Get the user object from the database.
		fromDB = true
		user = UserStoreDB.execute("SELECT serialized FROM userstore"+
						" WHERE uid = ?;", uid)
		# Unserialize it.
		# TODO: handle case where UID is not in DB.
		user = YAML.load(user[0]['serialized'])
	end
	
	# Split the words.
	words = params[:message].downcase.split(/[\s,?!;:]+/)
	
	# Filter out some unneeded words.  May not need this soon.
	words.delete("a")
	words.delete("to")
	words.delete("the")
	words.delete("it")
	words.delete("i")
	words.delete("i'd")
	
	# Now we process the words.  We want to seperate action words from rest.
	newtasks = []
	# Iffy thing about this is that we only add each action once.  Not sure
	# if that is bad or not.
	ActionPhrases.each do |row|
		if words.include?(row["phrase"])
			newtasks << row["aid"]
			words.delete(row["phrase"])
		end
	end
	
	# Add new tasks.
	newtasks.each do |id|
		action = Actions[id]
		newtask = Task.new(id, action[:priority], id)
		user.addTask(newtask)
	end
	
	# TODO: Make signal make a whole lot more sense
	firstIteration = true
	newmessage = nil
	signal = 2
	moduser = nil
	until signal != 2
		# Perform the highest priority task.
		if user.tasks != nil and user.nextTask != nil
			if newmessage != nil
				newmessage2, signal, moduser =
							user.doTask(words)
				if newmessage2 != nil
					newmessage << "\\n\\n" + newmessage2
				end
			else
				newmessage, signal, moduser = user.doTask(words)
			end
		else
			# If necessary, suggest actions.
			if firstIteration and newmessage == nil
				newmessage = makeSuggestions(words)
			end
			
			if newmessage == nil
				newmessage = "I have no current tasks to "+
						"complete, how can I help you?"
			else
				newmessage << "\\n\\nI have no current tasks "+
						"to complete, how can I help "+
						"you?"
			end
			signal = 0
		end
		
		# This hack brought to you by Ruby's wonderful scoping system!
		# Passing object references by references would be handy!
		if moduser != nil then user = moduser end
		
		if newmessage == nil and signal != 2
			newmessage = "I don't understand what you are asking"+
				" can you rephrase your question?"
			signal = 0
		end
		
		# No longer on first iteration
		firstIteration = false
	end
	
	# TODO: Store history here.
	
	# Insert/update serialized user object, as needed.
	if fromDB
		UserStoreDB.execute("UPDATE userstore SET serialized=? WHERE"+
					" uid=?;", user.to_yaml, uid)
	else
		UserStoreDB.execute("INSERT INTO userstore (uid, serialized)"+
					" VALUES (?, ?)", uid, user.to_yaml)
	end
	
	# Return the user id, new message.
	return uid, newmessage
end
################################################################################

### Routes #####################################################################
before do
	if DEBUG_ON
		puts '[Params]'
		p params
	end
end

get '/' do
	"Hello, World"
end

get '/autosistant' do
	erb :chat
end

get '/autosistant/admin' do
	# TODO: Log-in.
	erb :admin
end

post '/autosistant/admin/ajax' do
	# TODO: Make sure Loged-in.
	# Process changes to the configuration database.
	changeSet = params[:changeSet]
	if "phrases" == changeSet
		# Aparently, no need to parse the incoming data.  Its a hash!
		changes = params[:json]
		
		# Get hash into a manageable form.  changes now an array.
		changes = changes.flatten.select{|x| x.kind_of?(Hash)}
		
		# Start a database transaction to protect against lost.
		ConfigDB.transaction do |db|
			# Delete all values in this table.
			db.execute("DELETE FROM actionphrases")
			
			# Insert each value into the database.
			changes.each do |change|
				db.execute("INSERT INTO actionphrases "+
					"(aid, phrase) VALUES (?, ?)",
					change["aid"].to_i, change["phrase"]);
			end
		end
		
		# Live update the ActionPhrases array.
		newphrases = ConfigDB.execute("SELECT * FROM actionphrases")
		ActionPhrases = newphrases
		
		# Return JSON message
		"{\n\t\"state\":\"1\"\n}"
	elsif "productsearch" == changeSet
		# The string to eventually send back.
		toRet = "{ \"state\": \"1\", \"results\": [ "
		
		# Get the search string.
		toSearch = params[:json]
		
		# Conduct a product search.
		results = ProductDB.execute("SELECT * FROM product WHERE "+
				"id = ? OR name LIKE ?", toSearch.to_i, 
						'%'+toSearch+'%')
		
		# Process the results.
		gothits = false
		results.each do |row|
			gothits = true
			toRet << "{ "
			toRet << "\"id\": \"#{row["id"]}\", "+
				"\"name\": \"#{row["name"]}\""
			toRet << " }, "
        	end
		if gothits
			2.times{toRet.chop!}	# Remove last two characters.
		end
		toRet << " ] }"
		
		# Return the message.
		toRet
	elsif "getProductConfig" == changeSet
		# Get the id
		pid = params[:json]
		
		# Prepare the return message.
		toRet = "{ \"state\": \"1\", \"results\": [ "
		
		# Run the query.
		results = ConfigDB.execute("SELECT I.id, I.name, P.value FROM "+
				"identifiercategories I LEFT OUTER JOIN "+
				"productidentifiers P "+
				"WHERE P.pid = ? AND P.icid = I.id",
					pid.to_i)
		
		# Loop through the results, return JSON string.
		gothits = false
		results.each do |row|
			gothits = true
			toRet << "{ "
			toRet << "\"id\": \"#{row["id"]}\", "+
				"\"name\": \"#{row["name"]}\", "
			if row["value"]
				toRet << "\"value\": \"#{row["value"]}\""
			else
				toRet << "\"value\": \"\""
			end
			toRet << " }, "
		end
		if gothits
			2.times{toRet.chop!}	# Remove last two characters.
		end
		toRet << " ] }"
		toRet
	elsif "updateProductConfig" == changeSet
		pid = params[:json]["pid"].to_i
		toInsert = params[:json]["sendData"]
		
		if toInsert == nil
			return "{\n\t\"state\":\"1\"\n}"
		end
		
		toInsert = toInsert.flatten.select{|x| x.kind_of?(Hash)}
		pid = params[:json]["pid"].to_i
		# Prepare the return message.
		
		# Setup a database transaction.
		ConfigDB.transaction do |db|
			db.execute("DELETE FROM productidentifiers WHERE pid=?",
					pid)
			
			toInsert.each do |item|
				db.execute("INSERT INTO productidentifiers "+
					"(pid, icid, value) VALUES (?, ?, ?)",
					pid, item["icid"].to_i, item["value"])
			end
		end
		"{\n\t\"state\":\"1\"\n}"
	elsif "updateICConfig" == changeSet
		# Get necessary data.
		icinfo = params[:json]["icinfo"]
		questioninfo = params[:json]["qinfo"]
		
		# Get it into the right form.
		icinfo = icinfo.flatten.select{|x| x.kind_of?(Hash)}
		questioninfo = questioninfo.flatten.select{|x| x.kind_of?(Hash)}
		
		# Update the database.
		ConfigDB.transaction do |db|
			# Delete all previous information.
			db.execute("DELETE FROM identifiercategories")
			db.execute("DELETE FROM identifierquestions")
			
			# Insert into identifiercategories
			icinfo.each do |item|
				db.execute("INSERT INTO identifiercategories "+
					"(name, priority) VALUES (?, ?)",
						item["name"],
						item["priority"].to_i)
			end
			
			# Insert into identifierquestions
			questioninfo.each do |item|
				id = db.execute("SELECT id FROM "+
						"identifiercategories WHERE "+
						"name=?", item["name"])[0]["id"]
				db.execute("INSERT INTO identifierquestions "+
					"(question, icid) VALUES (?, ?)",
						item["question"], id)
			end
		end

		# Finally, update the Identifier categories array.
		#	Note: This will generate a harmless warning.
		newarr = ConfigDB.execute("SELECT * FROM identifiercategories "+
					"ORDER BY priority ASC, id ASC")
		IdentCats = newarr
		
		# Return the state information.
		"{\n\t\"state\":\"1\"\n}"
	elsif "updateSystemOptions" == changeSet
		# Get the data to be inserted into the database.
		data = params[:json]
		data = data.flatten.select{|x| x.kind_of?(Hash)}
		
p data
		# Now we will insert it into the database.
		ConfigDB.transaction do |db|
			# Delete previous options.
			db.execute("DELETE FROM options")
			
			# Insert new values into database.
			data.each do |d|
				db.execute("INSERT INTO options (key, value) "+
					"VALUES(?, ?)", d["key"], d["value"])
			end
		end
		
		# Update constants.  Ignore warnings!
		CompanyName = ConfigDB.execute("SELECT value FROM options "+
				"WHERE key = ?", 'companyname')[0]["value"]
		NoreplyEmail = ConfigDB.execute("SELECT value FROM options "+
				"WHERE key = ?", 'email_noreply')[0]["value"]
		WelcomeMessage = ConfigDB.execute("SELECT value FROM options "+
				"WHERE key = ?", 'welcomemessage')[0]["value"]
		
		# Return success.
		"{\n\t\"state\":\"1\"\n}"
	else
		# Return JSON message with error state.
		"{\n\t\"state\":\"-1\"\n}"
	end
end

post '/autosistant-ajax' do
	uid, message = processRequest(params)
	#"{\n\t\"uid\":\"#{uid}\",\n\t\"message\":\"#{h(params[:message])}\"\n}"
	"{\n\t\"uid\":\"#{uid}\",\n\t\"message\":\"#{message}\"\n}"
end

get '/about' do
	# TODO: Write this code!
	"A research project by Graeme Douglas"
end

not_found do
	status 404
	'Oops!  The page is not found!'
end
################################################################################
