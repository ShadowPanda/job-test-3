# encoding: utf-8

JobTest3::Application.routes.draw do
	resources :messages
	match "/auth/:provider/callback", to: "authenticate#callback"
	match "/auth/failure", :to => "authenticate#failure"
	match "/auth/logout", :to => "authenticate#logout"

	match "/no-js", :to => "messages#no_js"
	root :to => "messages#index"
end
