require 'httparty'
require 'sinatra'
require './lib/word_guesser'
use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'suuuuper_secret'

get '/' do  
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

class RandomWord
  def self.word
    response = HTTParty.get('https://random-word-api.herokuapp.com/word')
    puts response
    response.body.gsub(/\W/, "")
  end
end

