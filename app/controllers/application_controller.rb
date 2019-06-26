class ApplicationController < ActionController::Base
	include SessionsHelper
	include BookmarksHelper
	include UsersHelper
end
