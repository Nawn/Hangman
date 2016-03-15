require_relative 'board.rb'
puts "\nHELLO, THANKS FOR PLAYING HANGMAN!\nTo load last save, type: load\nTo continue, press enter\nTo exit, type: exit"

response = gets.chomp

puts "Not implemented yet" if response.downcase == "load"
exit if response.downcase == "exit" || response.downcase == "load"

game = Hangman.new

until game.over?
  begin
    game.display
    game.turn(gets.chomp) #Prompts player for input
  rescue StandardError => e
    puts "\n\nError: #{e}"
    retry
  end
end

#put (Depending on whether the player won or not), You won! if they did win, You Ran out of guesses! if they did not
puts game.won? ? "You Guessed it! The word was '#{game.answer}'" : "You ran out of guesses! The word was '#{game.answer}'"