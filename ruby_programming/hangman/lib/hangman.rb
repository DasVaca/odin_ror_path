require 'msgpack'

class Game
  
  @@mem_card_path = 'mem_card'
  
  attr_accessor :misses, :guesses
  attr_reader :secret_word

  def initialize
    @secret_word = get_secret_word
    @misses = []
    @guesses = []
  end

  def play
    guessed = false

    print "Got saved games? (y/n): "
    load_game if gets.chomp == 'y'

    puts "Press ':s' save the game and ':q' to exit (':sq' for both)."
    until guessed || misses.length >= secret_word.length 
      puts "-"*20
      puts "#{secret_word.map {|c| guesses.include?(c) ? c: '_'}.join(' ')}"
      puts "You have #{secret_word.length - misses.length} misses left."
      puts "Your misses: #{misses.sort.join(', ')}"

      guess = nil
      loop do
        print "Guess Letter: "
        guess = gets.chomp.downcase
        
        if guess.include?(':')
          save_game if guess.include?('s')
          exit_game if guess.include?('q')
          next
        end

        guess = guess[0]
        break unless misses.include?(guess) || guesses.include?(guess)
      end

      if secret_word.include?(guess)
        guesses << guess
      else
        misses << guess
      end
      
      guessed = secret_word.all? {|c| guesses.include?(c) }
    end

    if guessed
      puts "Nice work!"
    else
      puts "Better luck next time"
    end

    puts "Secret word was #{secret_word.join}."
  end

  def exit_game
    puts "Adios"
    exit
  end

  def save_game
    puts "Saving game."

    game_data = MessagePack.dump({
      misses: misses,
      guesses: guesses,
      secret_word: secret_word
    })
    
    Dir.mkdir(@@mem_card_path) unless Dir.exist?(@@mem_card_path)

    timestamp = Time.now
    filename = File.join(@@mem_card_path, "game_#{timestamp}.dat")

    File.open(filename, 'w') { |f|
      f.write(game_data)
    }

    puts "Game saved."
  end

  def load_game
    return nil unless Dir.exists?(@@mem_card_path)

    games = Dir.children(@@mem_card_path)

    puts "I found this in the memory, please select one."
    games.each_with_index { |game, i| puts "#{i}. #{game}"}
    
    load_i = -1
    until load_i.between?(0, games.length-1)
      print "> "
      load_i = gets.chomp.to_i
    end
    
    path = File.join(@@mem_card_path, games[load_i])
    game_data = MessagePack.load IO.read(path)

    @secret_word = game_data["secret_word"]
    @misses = game_data["misses"]
    @guesses = game_data["guesses"]

    puts "Game loaded."
  end

  def get_secret_word
    unless File.exist? 'words.txt'
      STDERR.puts 'File with words not found.'
      return nil
    end

    IO.readlines('words.txt')
      .filter{|line| line.length.between?(6, 13)} # One more for the \n
      .sample
      .strip
      .downcase
      .split('')
  end
end

(Game.new).play
