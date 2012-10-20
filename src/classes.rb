require './actions.rb'

### Classes ####################################################################
### Array Modifications ###
class Array
	def searchtask_lte(value)
		imin = 0
		imax = self.length - 1
		toret = -1
		while imax >= imin
			idx = ((imin+imax) / 2).to_i
			if self[idx].priority <= value
				toret = idx
				imin = idx + 1
			elsif self[idx].priority > value
				imax = idx - 1
			end
		end
		return toret
	end
	# Returns index of last element less or equal to value.  Assumes sorted.
	def binsearch_lte_idx(value)
		imin = 0
		imax = self.length - 1
		toret = -1
		while imax >= imin
			idx = ((imin+imax) / 2).to_i
			if self[idx] <= value
				toret = idx
				imin = idx + 1
			elsif self[idx] > value
				imax = idx - 1
			end
		end
		return toret
	end
end
################################################################################
### Task ###
class Task
	attr_accessor :priority
	attr_accessor :item
	attr_accessor :info
	
	### Variables
	@priority	# Task priority.
	@item		# Either a proc or a list of Tasks to complete.
	@info		# Contains information specific to this task.
	
	### Methods
	def initialize(priority, item)
		@priority = priority
		@item = item
		@info = Hash.new
	end
end

### User ###
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
	def initialize(id)
		@id = id
		@info = Hash.new
		@tasks = []
		@toBuy = Hash.new
	end
	def to_s
		"id: #{id}"
	end
	def addTask(t)
		if !t.kind_of?(Task)
		else
			# Get insert index.
			insertAt = @tasks.searchtask_lte(t.priority)+1
			# Add the item.
			@tasks.insert(insertAt, t)
		end
	end
	def nextTask()
		@tasks[0]
	end
	def doTask(idents, t=self.nextTask)
		if t.item.kind_of?(Array)
			self.doTask(idents, t.item)
		elsif t.item.kind_of?(Integer)
			return Actions[t.item][:code].call(idents, t.info)
		else
			# TODO: Perhaps throw an error here?
		end
	end
end
