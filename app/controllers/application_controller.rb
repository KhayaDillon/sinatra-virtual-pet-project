require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    #directs to login page if user already exists
    erb :'/users/signup'
  end

  post '/signup' do
    user = User.create(params)
    session[:user_id] = user.id
    redirect "/users/#{user.slug}"
  end

  get '/login' do
    erb :'/users/login'
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
    if logged_in?
      @user = current_user
      erb :'/users/show'
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
      #add error message
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
      @pet = Pet.find_by_slug(params[:slug])
      erb :'/pets/edit'
    end
  end

  patch '/pets/:id' do
    pet = Pet.find(params[:id])
    pet.update(params)
    redirect "/pets/#{pet.slug}"
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
