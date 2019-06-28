class ApplicationController < ActionController::Base
	include SessionsHelper
	include BookmarksHelper
	include UsersHelper

	skip_before_action :verify_authenticity_token
end
