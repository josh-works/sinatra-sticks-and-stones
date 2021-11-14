require 'sinatra'
require './lib/rgyb_game'
use Rack::Session::Cookie, :key => 'jacked.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'some_secret'

get '/' do  
  session["m"] = "it me, focus"
  redirect '/food'
end

get '/food' do
  
  "
   Ruby:    #{RUBY_VERSION}
   Rack:    #{Rack::VERSION}
   Sinatra: #{Sinatra::VERSION}
   #{session['m'].inspect}
 "
   # session["name"] = "i haz cookie"
   # # session["pages"] << "/food_form"
   # erb :food_form
end

post '/food' do
  session["name"] = "/food"
  erb :food_form, locals: {
                            params: params,
                            game: game,
                            session: session
                          }
end

def game
  @game ||= RgybGame.new
end