################################################################################
# Author:		Graeme Douglas
##
# Code and logic for user interation.
################################################################################

### Classes ####################################################################
class User
	attr_accessor :id
	attr_accessor :info
	attr_accessor :tasks
	attr_accessor :toBuy
	### Variables
	# Per-instance variables
	@id		# The user id.
	@info		# A hash of information collected.
	@tasks		# A list/array of tasks.
	@toBuy		# A hash containing products to be purchased.
	### Methods
	def initialize()
	end
	def to_s
		"id: #{id}"
	end
end
################################################################################

