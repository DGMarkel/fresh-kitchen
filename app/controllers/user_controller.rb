class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if !logged_in?
  erb :'/users/create_user'
    else
  redirect :"/users/#{current_user.slug}"
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:password].empty?
      if !User.find_by(username: params[:username])
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect to :"/users/#{current_user.slug}"
      else
        flash[:message] = "An account already exists for #{params[:username]}."
        redirect :'/signup'
      end
    else
      flash[:message] = "You must fill in all required fields."
      redirect :'/signup'
    end
  end

  get '/login' do
    if !logged_in?
  erb :'/users/login'
    else
  redirect :"/users/#{current_user.slug}"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :"/users/#{current_user.slug}"
    else
      flash[:message] = "Invalid Entry.  Please try again."
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
