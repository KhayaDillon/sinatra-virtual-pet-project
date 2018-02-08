class PetsController < ApplicationController

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
    else
      redirect '/login'
    end
  end

  get '/pets/:slug/edit' do
    @pet = Pet.find_by_slug(params[:slug])
    if logged_in? && @pet.user == current_user
      erb :'/pets/edit'
    else
      redirect '/'
    end
  end

  post '/pets/:id' do
    pet = Pet.find(params[:id])
    pet.update(params)
    redirect "/pets/#{pet.slug}"
  end

  get '/pets/:slug/delete' do
    @pet = Pet.find_by_slug(params[:slug])
    if logged_in? && @pet.user == current_user
      erb :'/pets/delete'
    else
      redirect '/'
    end
  end

  delete '/pets/:id/delete' do
    pet = Pet.find(params[:id])
    pet.delete
    redirect "/users/#{current_user.slug}"
  end

end
