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

get '/delete/:numero' do
  post = Post.get(params[:numero])
  if post != nil
    post.destroy
  end
  redirect '/'
end

get '/edit/:numero' do
  erb :edit
end

post '/edit/:numero' do
  @edit = Post.get(params[:numero])
  @edit.update(body: params[:post][:message])
  redirect '/'
end