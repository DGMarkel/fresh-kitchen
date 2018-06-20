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

  get '/users/:user_slug/:food_type' do
    @food_type = params[:food_type]
    erb :'/foods/show_food'
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
