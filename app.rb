require 'sinatra'
require './lib/rgyb_game'
enable :sessions

get '/' do  
  session["m"] = "it me, jjjosh"
  redirect '/food'
end

get '/food' do
  # session["name"] = "i haz cookie"
  # # session["pages"] << "/food_form"
  # erb :food_form
  "
   Ruby:    #{RUBY_VERSION}
   Rack:    #{Rack::VERSION}
   Sinatra: #{Sinatra::VERSION}
   #{session['m'].inspect}
 "
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