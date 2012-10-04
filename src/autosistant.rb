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

require './config.rb'		# System wide configuration options
if (DEBUG_ON)
	require 'shotgun'	# Restart server on each page refresh
end
################################################################################

### Helpers ####################################################################
helpers do
	include Rack::Utils
	alias_method :h, :escape_html
end
################################################################################

### Routes #####################################################################
get '/' do
	"Hello, World"
end

get '/autosistant' do
	erb :chat
end

post '/autosistant-ajax' do
	"Message received! You sent: \"#{h(params[:message])}\""
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
