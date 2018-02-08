require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if User.find_by(username: params[:username])
      flash[:message] = "Username already taken. Please try a different one."
      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    if logged_in? && current_user.slug == params[:slug]
      @user = current_user
      erb :'/users/show'
    else
      redirect '/'
    end
  end

  get '/pets/new' do
    if logged_in?
      @user = current_user
      erb :'/pets/new'
    end
  end

  post '/pets' do
    if current_user.pets.any? { |pet| pet.name == params[:name] }
      flash[:message] = "Name already taken. Please try a different one."
      redirect '/pets/new'
    else
      pet = Pet.create(params)
      current_user.pets << pet
      redirect "/pets/#{pet.slug}"
    end
  end

  get '/pets/:slug' do
    if logged_in?
      @pet = Pet.find_by_slug(params[:slug])
      erb :'/pets/show'
    end
  end

  get '/pets/:slug/edit' do
    if logged_in?
      @pet = Pet.find(params[:id])
      erb :'/pets/edit'
    end
  end

  post '/pets/:id' do
    pet = Pet.find(params[:id])
    pet.update(params)
    redirect "/pets/#{pet.slug}"
  end

  get '/pets/:slug/delete' do
    if logged_in?
      @pet = Pet.find_by_slug(params[:slug])
      erb :'/pets/delete'
    end
  end

  delete '/pets/:id/delete' do
    pet = Pet.find(params[:id])
    pet.delete
    redirect "/users/#{current_user.slug}"
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    end
  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
