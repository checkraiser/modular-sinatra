class SinatraApp
  class CoursesController
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    before do
      @current_ability ||= ::MyAbility.new(current_user)
    end

  	get '/' do 
  		@courses = Course.all
  		haml :course_index, :layout => :layout
  	end

    get '/new' do 
      haml :course_new, :layout => :layout
    end
  	  	
  	post '/create' do 
  		if params[:code].present? and params[:name].present?
  			course = Course.where(code: params[:code]).first_or_create!
  			course.name = params[:name]
  			course.save!  		
  			flash[:success] = "Course was created successfully"
  			redirect '/courses/' + course.id.to_s
  		else
  			flash[:error] = "Course was created error"
  			redirect '/new'
  		end  		
  	end

    get '/:id' do
      @course = Course.find(params[:id])
      if @course 
        haml :course_show, :layout => :layout
      else
        redirect '/courses'
      end
    end 

    post '/:course_id/enrollments' do       
      @course = Course.find(params[:course_id])
      authorize! :manage, @course
      @user = User.find(params[:user2_id])            
      @enrollment = @course.enrollments.where(user_id: @user.id).first_or_create!
      @enrollment.role = params[:role]      
      if @enrollment.save
        flash[:success] = "Create enrollment successfully"
        redirect '/courses/' + params[:course_id]
      else
        flash[:error] = "Create enrollment error"
        redirect '/courses/' + params[:course_id]
      end
    end

    put '/:course_id/enrollments/:enrollment_id' do 
      authorize! :manage, @course
      @course = Course.find(params[:course_id])
      @enrollment = Enrollment.find(params[:enrollment_id])
      @enrollment.update_attributes(role: params[:role])
      redirect '/courses/' + params[:course_id]
    end

    delete '/:course_id/enrollments/:enrollment_id' do 
      authorize! :manage, @course
      @course = Course.find(params[:course_id])
      @enrollment = Enrollment.find(params[:enrollment_id])
      if @enrollment.destroy
        flash[:success] = "Destroy successfully"
        redirect '/courses/' + params[:course_id]
      else
        flash[:error] = "Destroy failed"
        redirect '/:courses/' + params[:course_id]
      end
    end
  end
end