require_relative 'gameui'

class Game
  
  include GameUI

  @@guess_size = nil
  @@rounds = 12

  S_RNRP = 'X'
  S_RNWP = 'O'

  attr_accessor :history

  def initialize(guess_size)
    @@guess_size = guess_size
    @history = []
  end

  def play
    show_instructions(S_RNRP, S_RNWP)

    code = get_code_data generate_code 
    for round in (1..@@rounds)
      guess = get_user_guess
      feedback = get_feedback(code, guess)
      
      history << {guess: guess, feedback: feedback}

      show_game history

      break if code[:code].join == guess
    end

    puts "The code was #{code[:code].join} and your last guess was #{guess}"
    show_gameover code[:code].join == guess
  end

  def generate_code
    code = [] 
    @@guess_size.times { code << (rand(@@guess_size) + 1)}
    code
  end

  def get_code_data code
    data = code.reduce(Hash.new(0)) do |r, d|
      r[d] += 1
      r
    end
    data[:code] = code
    data
  end

  def get_feedback (code, guess)
    rnrp = Hash.new(0) # right number right place
    rnwp = Hash.new(0) # right number wrong place
    
    guess.to_i.digits.reverse.each_with_index do |d, i|
      if code[:code][i] == d 
        code[d] -= 1
        rnrp[d] += 1
        rnwp[d] -= 1 if rnwp[d] > 0
      elsif code[d] > rnwp[d]
        rnwp[d] += 1
      end
    end
    
    rnrp = rnrp.reduce(0) {|sum, (k, v)| sum + v}
    rnwp = rnwp.reduce(0) {|sum, (k, v)| sum + v}

    S_RNRP*rnrp + S_RNWP*rnwp
  end

  def valid? guess
    guess.to_i.digits.size == @@guess_size and guess.to_i.digits.all? { |d| d.between?(1, @@guess_size)}
  end

  def get_user_guess
    guess = nil
    loop do
      print "Your guess: "
      guess = gets.chomp
      exit if guess == 'q'
      break if valid? guess
      puts "Please enter a valid guess."
      puts "Must be #{@@guess_size} length and each digit moving between that range aswell."
    end
    guess
  end
end

(Game.new(4)).play
