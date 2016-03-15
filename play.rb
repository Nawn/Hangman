require_relative 'board.rb'
puts "\nHELLO, THANKS FOR PLAYING HANGMAN!\nTo load last save, type: load\nTo continue, press enter\nTo exit, type: exit"

response = gets.chomp

puts "Not implemented yet" if response.downcase == "load"
exit if response.downcase == "exit" || response.downcase == "load"

game = Hangman.new

until game.guesses_left <= 0 || game.over?
  begin
    game.display
    game.turn(gets.chomp)
  rescue StandardError => e
    puts "\n\nError: #{e}"
    retry
  end
end

puts "You Guessed it! The word was '#{game.answer}'" if game.over?
puts "You ran out of guesses! The word was '#{game.answer}'" if game.guesses_left <= 0