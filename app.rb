require 'sinatra'
require './lib/rgyb_game'

get '/' do
  game = RgybGame.new
  
  erb :index, locals: { game: game }
end