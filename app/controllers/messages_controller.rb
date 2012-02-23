# encoding: utf-8

class MessagesController < ApplicationController
	before_filter :setup

	def setup
		# Used into the JS
		@paths ||= {
			:root => url_for(:root),
			:index => [url_for(:action => :index, :page => "__"), "GET"],
			:new => [new_message_path, "GET"],
			:create => [messages_path, "POST"],
			:edit => [edit_message_path("__"), "GET"],
			:show => [message_path("__"), "GET"],
			:update => [message_path("__"), "PUT"],
			:delete => [message_path("__"), "DELETE"]
		}
	end

	def can_edit?(record)
		@current_user.present? && @current_user.try(:id) == record.try(:user_id)
	end

	def no_js
	end

	def index
		# Adjust parameters
		page = params[:page].to_integer
		page = 1 if page < 1
		per_page = params[:per_page].to_integer
		per_page = nil if per_page < 1

		# Get records
		@records = Message.order('updated_at DESC').paginate(:page => page, :per_page => per_page).all
		render :layout => false if request.xhr?
	end

	def new
		@record = Message.new
		self.edit
	end

	def create
		@record = Message.new
		self.update
	end

	def show
		begin
			@record = Message.find(params[:id]) if @record.blank?
			render "_message.html", :layout => (request.xhr? ? false : "application"), :locals => {:record => @record, :details => params[:detailed].to_boolean}
		rescue Exception => e
			render :text => e.to_s, :status => 404
		end
	end

	def edit
		begin
			@record = Message.find(params[:id]) if @record.blank?
			raise SecurityError.new if !self.can_edit?(@record)

			@creating = @record.new_record?

			render "form.html", :layout => (request.xhr? ? false : "application")
		rescue OAuth::Unauthorized.new() => o
			render :text => o.to_s, :status => 403
		rescue Exception => e
			render :text => e.to_s, :status => 404
		end
	end

	def update
		begin
			@record = Message.find(params[:id]) if @record.blank?
			raise SecurityError.new if !self.can_edit?(@record)

			@record.attributes = params[:message]
			@record.user = @current_user
			@record.save

			self.show
		rescue OAuth::Unauthorized => o
			render :text => o.to_s, :status => 403
		rescue Exception => e
			render :text => e.to_s, :status => 500
		end
	end

	def destroy
		begin
			@record = Message.find(params[:id]) if @record.blank?
			raise SecurityError.new if !self.can_edit?(@record)

			@record.delete

			render :nothing => true, :status => 200
		rescue OAuth::Unauthorized => o
			render :text => o.to_s, :status => 403
		rescue Exception => e
			render :text => e.to_s, :status => 500
		end
	end
end
