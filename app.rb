require 'httparty'
require 'random-word'
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
  session["word"] ||= get_random_word
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

post '/new_word' do
  new_word = get_random_word(params["word_length"])
  session["word"] = new_word
  session["guesses"] = []
  
  redirect '/word_guesser'
end

get '/new_word' do
  session["word"] = get_random_word
  redirect '/word_guesser'
end

def get_random_word(length=4)
  file = File.open('words.txt', 'r')
  lines = file.readlines
  formatted = lines.map(&:chomp)
  
  by_length = formatted.group_by(&:length)
  
  by_length[length.to_i].sample
end