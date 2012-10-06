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
ConfigDB = SQLite3::Database.new('sqlite/config.db')
ProductDB = SQLite3::Database.new('sqlite/product.db')
UserStoreDB = SQLite3::Database.new('sqlite/userstore.db')
ConfigDB.results_as_hash = true
ProductDB.results_as_hash = true
UserStoreDB.results_as_hash = true

# Do some initial queries.
Actions = ConfigDB.execute("SELECT * FROM actions;")
ActionPhrases = ConfigDB.execute("SELECT * FROM actionphrases;")
IdentCats = ConfigDB.execute("SELECT * FROM identifiercategories;")
require './config.rb'		# System wide configuration options
require './tasks.rb'		# System tasks code.
require './users.rb'		# User session code.
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
		# Must create new user object.
		user = User.new
		result = 1
		
		# Ensure we generate a unique uuid.
		until result == 0
			uid = SecureRandom.uuid
			result = UserStoreDB.execute("SELECT COUNT(*) as count"+
					" FROM userstore WHERE uid = ?;", uid)
			result = result[0]["count"]
		end
	else
		# Get the user object from the database.
		fromDB = true
		user = UserStoreDB.execute("SELECT serialized FROM userstore"+
						" WHERE uid = ?;", uid)
		# Unserialize it.
		user = YAML.load(user[0]['serialized'])
	end
	
	# Split the words.
	words = params[:message].split(/[\s,.?!;:]+/)
	
	# Insert/update serialized user object, as needed.
	if fromDB
		UserStoreDB.execute("UPDATE userstore SET serialized=? WHERE"+
					" uid=?;", user.to_yaml, uid)
	else
		UserStoreDB.execute("INSERT INTO userstore (uid, serialized)"+
					" VALUES (?, ?)", uid, user.to_yaml)
	end
	
	# Return the user id, new message.
	return uid, ""
	
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

post '/autosistant-ajax' do
	uid, message = processRequest(params)
	"{\n\t\"uid\":\"#{uid}\",\n\t\"message\":\"#{h(params[:message])}\"\n}"
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