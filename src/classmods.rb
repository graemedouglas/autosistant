################################################################################
# Author:		Graeme Douglas
##
# Class mods used throughout the project.
################################################################################

### Array modifications ########################################################
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
