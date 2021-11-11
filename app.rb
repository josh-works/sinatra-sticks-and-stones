require 'sinatra'
require './lib/rgyb_game'

get '/' do  
  erb :index, locals: { game: game }
end

get '/food_form' do
  erb :food_form
end

post '/food' do
  erb :food_form, locals: {params: params,
                          game: game}
end

def game
  @game ||= RgybGame.new
end