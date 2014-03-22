require 'sinatra/base'

module Sinatra
  module SessionAuth

    module Helpers
      def authorized?
        session[:user_id]
      end

      def current_user
        @user || (@user= User.find(session[:user_id]) if session[:user_id]) 
      end

      

      def logout!
        session[:user_id] = false
      end
    end

    def self.registered(app)     
      app.helpers SessionAuth::Helpers

      app.get '/login' do
        haml :login, :layout => :layout
      end

      app.get '/logout' do 
        session[:user_id] = false
        redirect '/'
      end

      app.post '/login' do
        us = UserService.authenticate(params[:email], params[:password])
        if us
          session[:user_id] = us.id
          redirect '/'
        else
          session[:user_id] = false
          flash[:error] = "Invalid account"
          redirect '/login'
        end
      end
      
      app.get '/signup' do
        haml :signup, :layout => :layout
      end

      app.post '/signup' do 
        us = UserService.signup(params[:email], params[:password])
        if us
          flash[:success] = "Signup successfully"
          redirect '/login'
        else
          flash[:error] = "Signup failed"
          redirect '/signup'
        end
      end

    end
  end

  register SessionAuth
end


