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

    code = generate_code
    for round in (1..@@rounds)
      guess = get_user_guess
      feedback = get_feedback(code, guess)
      
      history << {guess: guess, feedback: feedback}

      show_game history

      break if code == guess
    end

    show_gameover code == guess
  end

  def generate_code
    code = "" 
    @@guess_size.times { code << (rand(@@guess_size) + 1).to_s }
    code
  end

  def get_feedback (code, guess)
    rnrp = 0 # right number in right place
    rnwp = 0 # right number in wrong place
    @@guess_size.times do |i|
      if code[i] == guess[i]
        rnrp += 1
      elsif code.include? guess[i]
        rnwp += 1
      end
    end
    S_RNRP*rnrp + S_RNWP*(rnwp)
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
