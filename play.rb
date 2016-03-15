require_relative 'board.rb'
done = false
until done
  puts "\nHELLO, THANKS FOR PLAYING HANGMAN!\nTo load last save, type: load\nTo continue, press enter\nTo exit, type: exit"

  response = gets.chomp

  exit if response.downcase == "exit"
  game = Hangman.load if response.downcase == "load"

  game ||= Hangman.new

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
  puts "Play again? Anything to continue, No to exit"
  again = gets.chomp #get the response to the quesiton
  done = true if again.downcase == "n" || again.downcase == "no" #They are done, if they do not want to play again.
end