# Replace Method with Method Object
# =================================

# Problem: You have a long method that uses local variables in such a way that you cannot apply Extract Method.

# Solution: Turn the method into its own object so that all the local variables become instance variables on that object. You can then decompose the method into other methods on the same object.

# EXAMPLE from the text (p.152)

class Account
  def gamma(input_val, quantity, year_to_date)
    important_value1 = (input_val * quantity) + delta
    important_value2 = (input_val * year_to_date) + 100
    if (year_to_date - important_value1) > 100
      important_value2 -= 20
    end
    important_value3 = important_value2 * 7
    # and so on.
    important_value3 - 2 * important_value1
  end
end

# Solution: see "Mechanics" (p.152)

class Gamma
  attr_reader :account, # <-- this is the attribute for the object that hosted the original method
              :input_val, # <-- this was a parameter
              :quantity,
              :year_to_date,
              :important_value1, # <-- this was a temp variable
              :important_value2,
              :important_value3

  def initialize(account, input_val_arg, quantity_arg, year_to_date_arg)
    @account = account
    @input_val = input_val_arg
    @quantity = quantity_arg
    @year_to_date = year_to_date_arg
  end

  def compute
    @important_value1 = (input_val * quantity) + @account.delta
    @important_value2 = (input_val * year_to_date) + 100

    if (year_to_date - important_value1) > 100
      @important_value2 -= 20
    end

    @important_value3 = important_value2 * 7
    @important_value3 - 2 * important_value1
  end
end

# Now we have:

class Account
  def gamma(input_val, quantity, year_to_date)
    Gamma.new(self, input_val, quantity, year_to_date).compute
  end
end

# and we can use Extract Method on the compute() method without
# worrying about the argument's passing:

def compute
  @important_value1 = (input_val * quantity) + @account.delta
  @important_value2 = (input_val * year_to_date) + 100
  important_thing

  @important_value3 = important_value2 * 7
  @important_value3 - 2 * important_value1
end

def important_thing
  if (year_to_date - important_value1) > 100
    @important_value2 -= 20
  end
end

# Don't forget to test!