class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_and_belongs_to_many :bookmarks

	attr_accessor :remember_token

	has_secure_password

	before_create :set_uuid

	before_save { email.downcase! }

	validates :name, presence: true, length: { maximum: 20 }
	validates :email, presence: true,
										length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :password, presence: true,
											 length: { minimum: 6 }		

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end							

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def forget 
		update_attribute(:remember_digest, nil)
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def set_uuid
		self.id = SecureRandom.uuid
	end

	def subscribe!
		update_attribute(:subscribed, true)
	end

end	
