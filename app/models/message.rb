# encoding: utf-8

class Message < ActiveRecord::Base
	self.per_page = 25

	belongs_to :user
end