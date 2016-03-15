require 'yaml'
class Hangman
	attr_reader :guesses_left, :answer
	#Class Method, to pick a random word
	def self.select_random_word_from(filename, min_size=5, max_size=12)
		potential_words = []
		File.open(filename, "r") do |file|
			potential_words = file.readlines.select do |word|
				word.chomp.size > min_size && word.chomp.size < max_size #Potential_words Array 
			end
		end
		potential_words.sample.chomp #Return a random word, and get rid of the '\n' at the end.
	end
	#Class method, returns Hangman Object
	def self.load
		if File.exist? "save_file.txt"
			File.open("save_file.txt", "r") do |file|
				YAML::load(file.read) #Open the file, and return the Hangman object
			end
		else
			puts "File does not exist!\nContinuing with new game"
		end
	end

	#.new Method
	def initialize(guesses=10, answer=Hangman.select_random_word_from("words.txt")) #No word is set, it will pull a random
		@guesses_left = guesses #Int
		@answer = answer #String
		@incorrect_letters = [] #Array
		@solved = convert_answer(@answer) #Returns Array
	end

	#Display Data to screen
	def display
		puts "\n\nIncorrect Guesses Left: #{@guesses_left}"
		puts "Incorrect Guesses: #{@incorrect_letters.join(", ")}"
		puts "Progress: #{@solved.join(" ")}" #Join the array with Spaces, so it's readable
	end

	def turn(input_char)
		#Raise error if the input is not valid
		raise(StandardError, "1 Letter at a time!!") unless input_char.length == 1 || input_char.downcase == "save" || input_char.downcase == "exit"
		exit if input_char.downcase == 'exit'#Exit game if they type 'exit' this turn

		if @answer.split("").any? {|letter| letter == input_char} #If the input letter exists in the answer
			@answer.split("").each_with_index do |letter, index| #Go through the answer
				@solved[index] = input_char if letter == input_char #And set the letter in the solved array
			end
		elsif input_char.downcase == "save" #save if they type "save"
			puts "Saving game..."
			save() #Run the save method
			puts "Saved game!" 
		else #if they're not exitting, saving, or putting a correct letter
			@incorrect_letters << input_char #Add the letter they tried to an array of incorrect letters
			@guesses_left -= 1 #Then subtract an available guess
		end
	end

	def over? #Returns true if play ran out of turns(Lost), or won
		@guesses_left <= 0 || won?
	end

	def won?
		!@solved.include?("_") #If there are any underscores left, the word is not complete.
	end

	def save
		info = YAML::dump(self)
		File.open("save_file.txt", "w") do |file|
			file.write(info) #open/create file and write current object info.
		end
	end

	private
	#returns an array of underscores based 
	def convert_answer(input_string)
		return_array = []
		input_string.length.times do
			return_array << "_"
		end
		return_array
	end
end