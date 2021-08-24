module GameUI

  def show_game(history)
=begin
  history: Array of hashes with guess and feedback as keys.
=end
    puts "Game History"
    width = history.first[:guess].length
    puts '+' + '-'*width+ '+'
    history.each do |h|
      puts "|#{h[:guess]}| #{h[:feedback]}"
    end
    puts '+' + '-'*width + '+'
  end

  def show_instructions(s_rnrp, s_rnwp)
    puts %Q(
      The goal in this game is to break the code 
      by following the feedback given at each attempt.

      The code consists of 4 to 6 numbers between
      that same range.

      The game uses que following symbolism.
      #{s_rnrp} - A correct number in the right place
      #{s_rnwp} - A correct number in the wrong place
      
      The player must guess the code in less than 12 attempts.
    )
  end

  def show_gameover(winner)
    if winner
      puts "Such a good detective. Congratulations!"
    else
      puts "Better luck next time :C"
    end
  end

end
