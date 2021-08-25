class Player
  
  def get_guess(size); end
  
  def get_secret_code(size); end

  def think(history); end

end

class Human < Player
  
  def get_code size
    get_code_input("Secret code: ", size)
  end

  def get_guess size
    get_code_input("Your guess: ", size)
  end

  private
  def get_code_input(question, size)
    loop do
      print question
      input = gets.chomp
      exit if input == 'q'
      return input if valid?(input, size) 
      puts "Please enter a valid code."
      puts "Must be #{size} length and each digit moving between that range aswell."
    end
  end

  def valid?(code, size) 
    code.to_i.digits.size == size and code.to_i.digits.all? { |d| d.between?(1, size)}
  end
end

class Bot < Player
  def get_code size
    code = [] 
    size.times { code << (rand(size) + 1)}
    code.join
  end

  def get_guess size
    get_code size
  end
end
