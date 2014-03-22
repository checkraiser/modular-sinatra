class Course < ActiveRecord::Base
	has_many :enrollments, :dependent => :destroy	
end