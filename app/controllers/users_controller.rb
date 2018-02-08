class UsersController < ApplicationController

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


end
