class Hangman
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

	#.new Method
	def initialize(guesses=10, answer=Hangman.select_random_word_from("words.txt")) #No word is set, it will pull a random
		@guesses_left = guesses #Int
		@answer = answer #String
		@incorrect_letters = [] #Array
		@solved = convert_answer(@answer) #Returns Array
	end

	#Display Data to screen
	def display
		puts "Incorrect Guesses Left: #{@guesses_left}"
		puts "Incorrect Letters: #{@incorrect_letters}"
		puts "Progress: #{@solved.join(" ")}" #Join the array with Spaces, so it's readable
	end

	def test
		puts "Testing @answer: #{@answer}"
		puts "Testing @solved: #{@solved.join(" ")}" #Join the array with Spaces, so it's readable
	end

	def turn; end

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