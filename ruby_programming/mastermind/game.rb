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
    code = generate_code
    for round in (1..@@rounds)
      guess = get_user_guess
      feedback = get_feedback(code, guess)
      
      history << {guess: guess, feedback: feedback}

      show_game history

      break if code == guess
    end
  end

  def generate_code
    code = "" 
    @@guess_size.times { code << (rand(@@guess_size) + 1).to_s }
    code
  end

  def get_feedback (code, guess)
    right_number = 0
    right_place = 0
    @@guess_size.times do |i|
      right_place += (code[i] == guess[i] ? 1: 0)
      right_number += (code.include?(guess[i]) ? 1: 0)
    end
    S_RNRP*right_place + S_RNWP*(right_number - right_place)
  end

  def valid? guess
    guess.to_i.digits.size == @@guess_size and guess.to_i.digits.all? { |d| d.between?(1, @@guess_size)}
  end

  def get_user_guess
    guess = nil
    loop do
      print "Your guess: "
      guess = gets.chomp
      break if valid? guess
      puts "Please enter a valid guess."
      puts "Must be #{@@guess_size} length and each digit moving between that range aswell."
    end
    guess
  end
end

(Game.new(4)).play
