
### Classes ####################################################################
### Task ###
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

### Array Modifications ###
class Array
	# Returns index of last element less or equal to value.  Assumes sorted.
	def binsearch_lte_idx(value, imin=0, imax=self.length)
		toret = 0
		while imax > imin or (imax == imin and toret == -1) 
			idx = ((imin+imax) / 2).to_i
			if self[idx] <= value
				toret = imin
				imin = idx + 1
			elsif self[idx] > value
				imax = idx - 1
			end
		end
		return toret
	end
end
################################################################################

