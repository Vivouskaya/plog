require 'rubygems'
require 'sinatra'

get '/' do
	erb :index
end

post '/form' do
	erb :form
end






