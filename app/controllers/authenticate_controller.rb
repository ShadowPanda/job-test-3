# encoding: utf-8

class AuthenticateController < ApplicationController
	skip_before_filter :check_authentication

	def logout
		cookies.delete(:upt)
		redirect_to :root
	end

	def failure
		redirect_to :root
	end

	def callback
		if request.env.has_key?("omniauth.auth") then
			authdata = request.env["omniauth.auth"]

			attributes = {
				:persistence_token => Digest::SHA256.hexdigest(params[:oauth_token] + Time.now.to_i.to_s),
				:nick => authdata[:info][:nickname],
				:name => authdata[:info][:name]
			}

			# Find the existing user
			user = User.find_by_nick(attributes[:nick])
			user = User.new if user.nil?

			begin
				user.attributes = attributes
				user.save
			rescue Exception => e
				raise e
			end

			cookies[:upt] = {:value => attributes[:persistence_token], :expires => 1.hour.from_now, :path => "/"}
		end

		redirect_to :root
	end
end
