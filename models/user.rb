class User < ActiveRecord::Base
	has_many :enrollments, :dependent => :destroy
	has_many :courses, :through => :enrollments
	def name
		(self.first_name || "") + " " + (self.last_name || "")
	end
end