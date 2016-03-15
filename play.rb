require_relative 'board.rb'
puts "\nHELLO, THANKS FOR PLAYING HANGMAN!\nTo load last save, type: load\nTo continue, press enter\nTo exit, type: exit"

response = gets.chomp

puts "Not implemented yet" if response.downcase == "load"
exit if response.downcase == "exit" || response.downcase == "load"

game = Hangman.new