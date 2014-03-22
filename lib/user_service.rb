require 'digest/md5'
class UserService
	def self.authenticate(email, password)
		user = User.where(email: email).first
		if user and user.password == md5(password)
			return user
		else
			return nil
		end
	end

	def self.signup(email, password)
		user = User.where(email: email).first
		if user
			return nil
		else
			user = User.create(email: email, password: md5(password))
			return user
		end		
	end

	def self.changepassword(user_id, oldp, newp)
		user = User.find(user_id)
		if user.password == oldp
			user.password = newp
			user.save!
		else
			return nil
		end
	end
	private
	def self.md5(p)
		Digest::MD5.hexdigest(p)
	end
end