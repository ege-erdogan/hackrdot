require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: 'Test User', email: 'user@example.com')
	end

	test 'should be valid' do
		assert @user.valid?
	end

	test 'should be present' do
		@user.name = ''
		assert_not @user.valid?
	end

	test 'email should be present' do
		@user.email = ''
		assert_not @user.valid?
	end		

	test 'name should not be too long' do
		@user.name = 'a' * 21
		assert_not @user.valid?
	end

	test 'email validation should accept valid addresses' do
		valid_addresses = %w[user@example.com ege@erdogan.dev A_US-ER@foo.bar.org]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid."
		end
	end

end
