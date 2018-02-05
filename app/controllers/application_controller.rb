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
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username].empty?|| params[:password].empty?
      redirect "/signup"
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/pets/#{user.slug}"
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/pets/#{user.slug}"
    else
      redirect to '/signup'
    end
  end

  get '/pets/new' do
    if logged_in?
      @user = current_user
      erb :'/pets/new'
    end
  end

  post '/pets/:slug' do

  end

  get '/pets/:slug' do
    if logged_in?
      @user = current_user
      erb :'/pets/index'
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
