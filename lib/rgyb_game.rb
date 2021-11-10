class RgybGame
  attr_reader :code, :user_guesses
  def initialize()
    @code = "rrrr"
    @user_guesses = []
  end  
  
  def play_game
    puts "Please guess a color combo of 'rgyb': "
    @user_guesses << gets.chomp
    if game_over
      puts "you're done! your guesses: #{user_guesses}"
      return 
    else
      play_game
    end
  end
  
  def game_over
    user_guesses.last == @code
  end
end

RgybGame.new.play_game