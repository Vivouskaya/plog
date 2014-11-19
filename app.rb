require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'pry'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :auteur, String
  property :body, Text
  property :created_at, DateTime

end

DataMapper.finalize

Post.auto_upgrade!


get '/' do
  @towel = Post.all(:order => [ :id.desc ], :limit => 20)
  erb :index
end

post '/log' do
  Post.create(:body => params[:message], :auteur => params[:auteur])
  redirect '/'
end

get '/delete/:id' do
  post = Post.get(params[:id])
  if post != nil
    post.destroy
  end
  redirect '/'
end

post '/edit/:id' do
  @edit = Post.get(params[:id])
  #@edit.update(body: params[:post][:body])
  erb :edit
end

post '/update/:id' do
  Post.get(params[:id]).update(:message => fast_escape_html(params[:message]))
  redirect '/'
end