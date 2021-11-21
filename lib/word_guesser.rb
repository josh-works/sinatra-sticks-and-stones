class WordGuesser
  attr_reader :word, :guesses
  def initialize(word, guesses)
    @word = word.chomp
    @guesses = guesses ||= []
  end
  
  def obscured_word
    p word
    "*" * word.chars.count
  end
  
  def current_guess
    guesses.last
  end
  
  def number_of_correct_letters
    return 0 if guesses.nil? || guesses.empty?
    
    (current_guess.chars & word.chars).count
  end
  
  def number_of_correct_placements
    return 0 if guesses.nil? || guesses.empty?

    temp = current_guess.chars
    word.chars.reduce(0) do |count, letter|
      count += 1 if letter == temp.shift
      count
    end
  end
end