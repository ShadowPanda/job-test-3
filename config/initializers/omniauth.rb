# encoding: utf-8

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :developer unless Rails.env.production?
	provider :twitter, "4mqQ4NCAlU8ykLMc4M4idQ", "0KlDR7OqTSUIg3ottsPZqob9wjG7AWqAHHiFZ1veuFg"
end