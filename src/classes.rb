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
### String modifications ###
class String
	### These next two methods are taken from Wikibooks algorithm
	### implementation.
	# Longest comm
	def longest_common_substring(s2)
		m = Array.new(s2.length){ [0] * s1.length }
		longest, x_longest = 0,0
		(1 .. 1 + s1.length).each do |x|
			(1 .. 1 + s2.length).each do |y|
				if s1[x-1] == s2[y-1]
					m[x][y] = m[x-1][y-1] + 1
					if m[x][y] > longest
						longest = m[x][y]
						x_longest = x
					else
						m[x][y] = 0
					end
				end
			end
		end
		s1[x_longest - longest .. x_longest]
	end
	
	# The longest common subsequence of two strings.
	def subsequence(s2)
		s1 = self
		return 0 if s1.empty? or s2.empty? or !s2.kind_of?(String)
		 
		num=Array.new(s1.size){Array.new(s2.size)}
		s1.scan(/./).each_with_index{|letter1,i|
		s2.scan(/./).each_with_index{|letter2,j|
			 
			if s1[i]==s2[j]
				if i==0||j==0
					num[i][j] = 1
				else
					num[i][j]  = 1 + num[i - 1][ j - 1]
				end
			else
				if i==0 && j==0
					num[i][j] = 0
				elsif i==0 &&  j!=0  #First ith element
					num[i][j] = [0,  num[i][j - 1]].max
				elsif j==0 && i!=0  #First jth element
					num[i][j] = [0, num[i - 1][j]].max
				elsif i != 0 && j!= 0
					num[i][j] = [num[i - 1][j],
							num[i][j - 1]].max
				end
			end
		}}
        num[s1.length - 1][s2.length - 1]
	end
end
################################################################################
### Task ###
class Task
	attr_accessor :id
	attr_accessor :priority
	attr_accessor :item
	attr_accessor :info
	
	### Variables
	@id		# The action id.
	@priority	# Task priority.
	@item		# Either a proc or a list of Tasks to complete.
	@info		# Contains information specific to this task.
	
	### Methods
	def initialize(id, priority, item)
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
			temp = @tasks[insertAt-1]
			if temp != nil and temp.priority == t.priority
			else
				# Add the item.
				@tasks.insert(insertAt, t)
			end
		end
	end
	def nextTask()
		@tasks[0]
	end
	def doTask(idents, t=self.nextTask)
		if t.item.kind_of?(Array)
			self.doTask(idents, t.item)
		elsif t.item.kind_of?(Integer)
			return Actions[t.item][:code].call(idents, self)
		else
			# TODO: Perhaps throw an error here?
		end
	end
	def updateOrder(pid, qty)
		if !(pid.kind_of?(Integer) and qty.kind_of?(Integer))
			# TODO: log the error.
		elsif @toBuy[pid] == nil
			@toBuy[pid] = qty
		else
			@toBuy[pid] += qty
		end
	end
	def emptyOrder?
		@toBuy.empty?
	end
end
