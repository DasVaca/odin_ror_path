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

end
