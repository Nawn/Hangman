class Hangman
	attr_reader :answer
	#Class Method, to pick a random word
	def self.select_random_word_from(filename, min_size=5, max_size=12)
		potential_words = []
		File.open(filename, "r") do |file|
			potential_words = file.readlines.select do |word|
				word.chomp.size > min_size && word.chomp.size < max_size
			end
		end
		potential_words.sample.chomp
	end

	#.new Method
	def initialize(guesses=10, answer=Hangman.select_random_word_from("words.txt"))
		@guesses_left = guesses
		@answer = answer
	end
end