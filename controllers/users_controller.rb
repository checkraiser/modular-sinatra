class SinatraApp
  class UsersController < ApplicationController
  	get '/' do 
  		@users = User.all
  		haml :user_index, :layout => :layout
  	end

    

    get '/new' do 
      haml :user_new, :layout => :layout
    end
  	  	
  	post '/create' do 
  		if params[:code].present? and params[:first_name].present? and params[:last_name].present
  			user = User.where(code: params[:code]).first_or_create!
  			user.first_name = params[:first_name]
        user.last_name = params[:last_name]
  			user.save!  		
  			flash[:success] = "User was created successfully"
  			redirect '/users' + course.id.to_s
  		else
  			flash[:error] = "User was created error"
  			redirect '/new'
  		end  		
  	end

    get '/:id' do
      @user = User.find(params[:id])
      if @course 
        haml :user_show, :layout => :layout
      else
        redirect '/'
      end
    end 

  end
end