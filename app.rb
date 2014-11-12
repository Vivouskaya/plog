require 'rubygems'
require 'sinatra'

get '/' do
	erb :index
end

post '/' do
	erb :form
end

get '/form' do
	"welcome"
	params[:name]
end

post '/form' do
	params[:message]
end




