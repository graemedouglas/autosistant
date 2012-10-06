################################################################################
# Author:		Graeme Douglas
##
# Code and logic for user interation.
################################################################################

### Requirements ###############################################################
require './classmods.rb'
require './tasks.rb'
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
	def addTask(t)
		if !t.kind_of?(Task)
		else
			# Get insert index. See classmods for this method.
			insertAt = @tasks.bsearch_lte_idex
			# Add the item.
			@tasks.insert(insertAt, t)
		end
	end
	def nextTask()
		@tasks[0]
	end
	def doTask(t)
		if t == nil
			t = self.nextTask
		end
		if t.item.kind_of?(Array)
			self.doTask(t)
		else
			# Do the task!
		end
	end
end
################################################################################

