# Substitute Algorithm
# ====================

# Problem: You have a nasty algorithm. You want to replace it with one that's clearer.

# Solution: Replace the body of the method with the new algorithm.

# EXAMPLE from the text (p.154)

def found_friends(people)
  friends = []
  people.each do |person|
    if(person == "Don")
      friends << "Don"
    end
    if(person == "John")
      friends << "John"
    end
    if(person == "Kent")
      friends << "Kent"
end end
  return friends
end

# Solution:

def found_friends(people)
  people.select do |person|
    %w(Don John Kent).include? person
  end
end

# NOTE from the author:
"Sometimes when you want to change the
algorithm to do something slightly different,
it is easier to substitute the algorithm first
into something easier for the change you need to
make."

# --> simply first, then replace


# Don't forget to test!