require_relative 'gameui'
require_relative 'player'

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

  def get_role
    loop do
      print %Q(
      ¿What role do you want to play as?
          1. breaker
          2. maker
      role:
      )
      role = gets.chomp.to_i

      return role if [1, 2].include? role

      puts "Please select a valid role."
    end
  end

  def play
    show_instructions(S_RNRP, S_RNWP)
    breaker, maker = Human.new, Bot.new
    
    if get_role == 2
      breaker, maker = maker, breaker
    end

    code = maker.get_code @@guess_size
    for round in (1..@@rounds)
      guess = breaker.get_guess @@guess_size
      feedback = get_feedback(code, guess)
      
      history << {guess: guess, feedback: feedback}

      breaker.think history

      show_game history

      break if code == guess
    end

    puts "The code was #{code} and the last guess was #{guess}"
    show_gameover code == guess
  end

  def get_code_data code
    data = code.to_i.digits.reduce(Hash.new(0)) do |r, d|
      r[d] += 1
      r
    end
    data
  end

  def get_feedback (code, guess)
    rnrp = Hash.new(0) # right number right place
    rnwp = Hash.new(0) # right number wrong place
    digits = get_code_data code
    
    guess.to_i.digits.reverse.each_with_index do |d, i|
      if code[i].to_i == d 
        digits[d] -= 1
        rnrp[d] += 1
        rnwp[d] -= 1 if rnwp[d] > 0
      elsif digits[d] > rnwp[d]
        rnwp[d] += 1
      end
    end
    
    rnrp = rnrp.reduce(0) {|sum, (k, v)| sum + v}
    rnwp = rnwp.reduce(0) {|sum, (k, v)| sum + v}

    S_RNRP*rnrp + S_RNWP*rnwp
  end
end

(Game.new(4)).play
