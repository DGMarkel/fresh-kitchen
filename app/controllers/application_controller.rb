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
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect :"/users/#{current_user.username}"
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to :"/users/#{@user.user_slug}"
    else
      redirect :'/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect :"/users/#{current_user.username}"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    redirect to :"/users/#{@user.user_slug}"
  end

  get '/users/:user_slug' do
    if logged_in?
      erb :'/users/show'
    else
      redirect :/
    end
  end

  get '/users/:user_slug/foods/new' do
    if logged_in?
      erb :'/foods/create_food'
    else
      redirect to :/
    end
  end

  post '/users/:user_slug/foods' do
    food = Food.create(params[:food])
    if params[:category][:id]
      food.update(category_id: params[:category][:id])
    elsif !params[:category][:name].empty?
        category_new = Category.create(name: params[:category][:name], user_id: current_user.id)
        food.update(category_id: category_new.id)
    else
      redirect :"/users/#{current_user.username}/foods/new"
    end
    category = Category.find_by(id: food.category_id)
    redirect to :"/users/#{current_user.user_slug}/#{category.slug}"
  end

  get '/users/:user_slug/:category' do
    if logged_in?
      category_id = Category.find_by_slug(params[:category]).id
      @foods = current_user.foods.where(category_id: category_id)
      erb :'/foods/show_food_by_category'
    else
      redirect :/
    end
  end

  get '/users/:user_slug/:category/:food' do
    if current_user.foods.find_by(name: params[:food].gsub("-", " "))
      @food = current_user.foods.find_by(name: params[:food].gsub("-", " "))
      erb :'/foods/show_food'
    end
  end

  get '/users/:user_slug/:category/:food/edit' do
    if logged_in?
      @food = current_user.foods.find_by(name: params[:food].gsub("-", " "))
      erb :'/foods/edit_food'
    else
      redirect :/
    end
  end

  post '/users/:user_slug/:category/:food' do
    @food = current_user.foods.find_by(name: params[:food].gsub("-", " "))
    binding.pry
    @food.update(params[:update])
    redirect :"/users/#{params[:user_slug]}/#{params[:category]}/#{params[:food]}"
  end

  delete '/users/:user_slug/:category/:food/delete' do
    if logged_in?
      food = current_user.foods.find_by(name: params[:food].gsub("-", " "))
      food.delete
      redirect :"/users/#{params[:user_slug]}/#{params[:category]}"
    else
      redirect :/
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
      redirect :/
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if logged_in?
        User.find(session[:user_id])
      end
    end

  end

end
