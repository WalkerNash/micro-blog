require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'
# require 'pry'

enable :sessions

#helper methods
def current_user
  @user ||= User.find_by_id(session[:user_id])
end

def authenticate_user
    redirect '/' if current_user.nil?
end

# Database configuration
set :database, "sqlite3:development.sqlite3"

# Define routes below
get '/' do
  # authenticate_user
  @posts = Post.all
  erb :index
end

#posts create
post '/' do
  authenticate_user
  username = params[:username]
  @user.posts.create(
    body: params[:body]
  )
  redirect '/'
end

# Fatima's routes
get '/logout' do
  session.clear
  redirect '/'
end

post '/login' do
  username = params[:username].downcase
  user = User.find_or_create_by(username: username)
  session[:user_id] = user.id
  redirect "/"
end
# End Fatima's routes
# *Dallas Start*
get '/profile/user_id' do
  @user = current_user
  @post = Post.where(params[:user_id])
get '/profile/:user_id' do
  @user = current_user
  @posts = Post.where(user_id: params[:user_id])
  erb :'profile'
end

post "/profile" do
  @user = current_user
  # @post.body.create(body: params[:body], user_id: params[:user_id])
  post = @user.posts.create(
    body: params[:body]
  )
  redirect "/profile/#{@user.id}"
end

# *Dallas End*
#Mike's routes start here

get '/account' do
  if current_user
    erb :account
  else
    redirect '/'
  end
end

patch '/profile' do
    @user = current_user
    @user.update(
    username: params[:username],
    f_name: params[:f_name],
    l_name: params[:l_name],
    location: params[:location],
    email: params[:email]
  )
  redirect "/profile/#{@user.id}"
end

delete '/' do
  @user = current_user
  #user = User.find_by_id(params[:id])
  @user.destroy
  redirect '/'
end
