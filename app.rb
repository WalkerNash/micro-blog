require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

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
  # current_user
  post = Post.create(
    body:params[:body],
    user_id: params[:user_id]
  )
  erb :index
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
get '/profile' do
  @user = current_user
  redirect "/profile/#{@user.id}"
  @posts = Post.find_by_id(params[:user_id])

end

get '/profile/:id' do
  @user = current_user
  @post = Post.find_by_id(params[:user_id])
  erb :'profile'
end

post "/profile/#{@user_id}" do
  @user = current_user
  # @post.body.create(body: params[:body], user_id: params[:user_id])
  post = Post.create(
    body: params[:body],
    user_id: params[:user_id]
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
