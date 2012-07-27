# encoding: utf-8

class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :check_authentication

	def check_authentication
		@current_user = nil

		begin
			@current_user = User.find_by_persistence_token(cookies[:upt])
		rescue
			@current_user = nil
		end
	end
end
