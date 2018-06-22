require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    if !logged_in?
      erb :welcome
    else
      redirect :"/users/#{current_user.username}"
    end
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
