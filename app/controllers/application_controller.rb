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
    erb :'/users/create_user'
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
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(params[:username])
    session[:user_id] = @user.id
    redirect to :"/users/#{@user.user_slug}"
  end

  get '/users/:user_slug' do
    erb :'/users/show'
  end

  get '/users/:user_slug/foods' do
    erb :'/foods/foods'
  end

  get '/users/:user_slug/foods/new' do
    erb :'/foods/create_food'
  end

  post '/users/:user_slug/foods' do
    current_user.foods << Food.create(params[:user])
    redirect to :"/users/#{current_user.user_slug}/foods"
  end

  get '/users/:user_slug/:category' do
    @foods = current_user.foods
    erb :'/foods/show_food_by_category'
  end

  get '/users/:user_slug/:category/:food' do
    if current_user.foods.find_by(name: params[:food])
      @food = current_user.foods.find_by(name: params[:food])
      erb :'/foods/show_food'
    end
  end

  get '/users/:user_slug/:category/:food/edit' do
    binding.pry
    @food = current_user.foods.find_by(name: params[:food])
    erb :'/foods/edit_food'
  end

  post '/users/:user_slug/:category/:food' do
    redirect to :'/users/:user_slug/:category/:food'
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
