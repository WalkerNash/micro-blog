require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

# Database configuration
set :database, "sqlite3:development.sqlite3"

# Define routes below
get '/' do
  erb :index
end



























































































































































































#Mike's routes start here

get '/account' do
  if current_user
    erb :account
  else
    redirect '/'
  end
end

patch '/profile/:id' do
  user = User.find_by_id(params[:id])
  user.update(
    username: params[:username],
    f_name: params[:f_name],
    l_name: params[:l_name],
    location: params[:location],
    email: params[:email]
  )
  redirect "/profile/#{user.id}"
end


delete '/profile/:id' do
  user = User.find_by_id(params[:id])
  user.destroy
  redirect '/'
end
