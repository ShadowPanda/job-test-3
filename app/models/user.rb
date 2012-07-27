# encoding: utf-8

class User < ActiveRecord::Base
	has_many :messages

	def profile_url
		"http://twitter.com/#!/#{self.nick}"
	end
end
