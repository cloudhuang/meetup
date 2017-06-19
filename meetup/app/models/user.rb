class User < ActiveRecord::Base
	has_secure_password

	has_many :issues
	has_many :comments

	before_create { generate_auth_token(:auth_token) }

	validates :username, :email, presence: true
	validates :username, :email, uniqueness: { case_sensitive: false }

	def gravatar
	  gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
	  "http://gravatar.com/avatar/#{gravatar_id}.png?s=512&d=retro"
	end

	private
	def generate_auth_token(column)
		begin
		  	self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end


end
