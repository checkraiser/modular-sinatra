class Enrollment < ActiveRecord::Base
	ENROLLMENTS = [:teacher, :student]
	belongs_to :user
	belongs_to :course
end