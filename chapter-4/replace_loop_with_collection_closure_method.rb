# Replace Loop with Collection Closure Method
# ===========================================

# Problem: You are processing a collection's elements in a loop. You want to make the code more readable.

# Solution: Replace the loop with a collection closure method.

# EXAMPLE from the text (p.156)
managers = []
employees.each do |e|
  managers << e if e.manager?
end

# solution:
managers = employees.select { |e| e.manager? }


# Another example and solution:
offices = []
employees.each { |e| offices << e.office }

# (map is an alias for collect)
offices = employees.collect { |e| e.office }


# What about a loop that includes more than one task?
# ---> chain 'em!
managerOffices = []
employees.each do |e|
  managerOffices << e.office if e.manager?
end

# solution:
managerOffices = employees.select {|e| e.manager?}.
                           collect {|e| e.office}

# Note from the author:
"It might be useful to think of this chaining as
a series of pipes and filters. Here, we’ve piped
the original collection through the select filter
and onto the collect filter. Also note the way
I’ve laid out the code here—listing each filter on
its own line makes the transformations a little clearer."

# Don't forget to test!