class UserController < ApplicationController
  use Rack::Flash

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
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :"/users/#{@user.user_slug}"
      flash[:message] = "Welcome back, #{current_user.username}."
    else
      redirect :'/login'
    end
  end

  get '/users/:user_slug' do
    if logged_in?
  erb :'/users/show'
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

end
