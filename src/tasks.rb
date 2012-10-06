################################################################################
# Author:		Graeme Douglas
##
# System task management code/logic.
################################################################################

### Classes ####################################################################
class Task
	attr_accessor :priority
	attr_accessor :item
	
	### Variables
	@priority	# Task priority.
	@item		# Either the task itself or a list of tasks to complete.
	
	### Methods
	def initialize()
	end
end
################################################################################
