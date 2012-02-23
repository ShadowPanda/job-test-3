# encoding: utf-8

JobTest3::Application.routes.draw do
	resources :messages
	match "no-js", :to => "messages#no_js"
	root :to => "messages#index"
end
