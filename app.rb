require 'sinatra'
require './lib/rgyb_game'

get '/' do
  game = RgybGame.new
  
  erb :index, locals: { game: game }
end

get '/food_form' do
  erb :food_form
end

post '/food' do
  params.to_s
end