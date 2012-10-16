
### Classes ####################################################################
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
	def initialize()
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
	def initialize()
	end
	def to_s
		"id: #{id}"
	end
	def searchtask_lte(value)
		imin = 0
		imax = self.length - 1
		toret = -1
		while imax >= imin
			idx = ((imin+imax) / 2).to_i
			if self.tasks[idx].priority <= value
				toret = idx
				imin = idx + 1
			elsif self.tasks[idx].priority > value
				imax = idx - 1
			end
		end
		return toret
	end
	def addTask(t)
		if !t.kind_of?(Task)
		else
			# Get insert index. See classmods for this method.
			insertAt = @tasks.searchtasks_lte(t.priority) + 1
			# Add the item.
			@tasks.insert(insertAt, t)
		end
	end
	def nextTask()
		@tasks[0]
	end
	def doTask(t=self.nextTask)
		if t.item.kind_of?(Array)
			self.doTask(t.item)
		else
			# Do the task!
		end
	end
end

### Array Modifications ###
class Array
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
