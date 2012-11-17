################################################################################
# Author:		Graeme Douglas
# Create date:		2012/09/29
# Modify date/time:	2012/09/29/15:48
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
	newmessage = nil
	signal = 2
	until signal != 2
		# Perform the highest priority task.
		if user.tasks != nil and user.nextTask != nil
			if newmessage != nil
				newmessage2, signal = user.doTask(words)
				if newmessage2 != nil
					newmessage << "\\n\\n" + newmessage2
				end
			else
				newmessage, signal = user.doTask(words)
			end
		else
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
		
		if newmessage == nil and signal != 2
			newmessage = "I don't understand what you are asking"+
				" can you rephrase your question?"
			signal = 0
		end
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
		# Parse incoming data.
		#changes = JSON.parse(params[:json])
		
		# Return JSON message
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
	"Graeme needs to write this code!"
end

not_found do
	status 404
	'Oops!  The page is not found!'
end
################################################################################
