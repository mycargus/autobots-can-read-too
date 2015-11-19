# Extract Surrounding Method
# ==========================

# Problem: You have two methods that contain nearly identical code.
# The variance is in the middle of the method.

# Solution: Extract the duplication into a method that accepts a block and yields back to the caller to execute the unique code.

# EXAMPLE from the text (p.158)
def charge(amount, credit_card_number)
  begin
    connection = CreditCardServer.connect(...)
    connection.send(amount, credit_card_number)
  rescue IOError => e
    Logger.log "Could not submit order #{@order_number} to the server: #{e}"
    return nil
  ensure
    connection.close
  end
end

# solution: One part Extract Method ...
def charge(amount, credit_card_number)
  connect do |connection| # <--- on this line of code, "connect" is a method call and the ruby block is the argument
    connection.send(amount, credit_card_number)
  end
end

# ... and one part closure
def connect
  begin
    connection = CreditCardServer.connect(...)
    yield connection # <--- this is when the block argument runs; in this case, `connection.send(amount, credit_card_number)`
  rescue IOError => e
    Logger.log "Could not submit order #{@order_number} to the server: #{e}"
    return nil
  ensure
    connection.close
  end
end

# BONUS: Separates business logic from the infrastructure logic required to iterate over the collection, which helps during maintenance.

# Don't forget to test!



