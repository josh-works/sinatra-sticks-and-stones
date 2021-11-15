require 'HTTParty'
require 'sinatra'
require './lib/rgyb_game'
use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'suuuuper_secret'

get '/' do  
  session["visit_count"] ||= 0
  session["visit_count"] += 1
  session["word"] = RandomWord.word

  erb :index, locals: { session: session }
end

get '/word_guesser' do
  session["word"] ||= RandomWord.word
  game = WordGuesser.new(session["word"], session["guesses"])
  
  erb :word_guesser, locals: { session: session,
                               game: game
                             }
end

post '/word_guesser' do
  session["guesses"] ||= []
  session["guesses"] << params["guess"]
  redirect '/word_guesser'
end

get '/food' do
  session["message"] = "in a bottle"
  erb :food_form, locals: { session: session }
end

post '/food' do
  session["name"] = "/food"
  redirect '/food'
end

def game
  @game ||= RgybGame.new
end

class RandomWord
  def self.word
    response = HTTParty.get('https://random-word-api.herokuapp.com/word')
    puts response
    response.body.gsub(/\W/, "")
  end
end

class WordGuesser
  attr_reader :word, :guesses
  def initialize(word, guesses)
    @word = word
    @guesses = guesses ||= []
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
