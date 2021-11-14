require 'sinatra'
require './lib/rgyb_game'
use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'suuuuper_secret'

get '/' do  
  session["visit_count"] ||= 0
  puts session["visit_count"]
  session["visit_count"] += 1
  puts "new session visit count: #{session["visit_count"]}"
  visit_count = session["visit_count"]
  erb :index, locals: { visit_count: visit_count }
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