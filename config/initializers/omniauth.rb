# encoding: utf-8

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :developer unless Rails.env.production?
	provider :twitter, "XUSVOkhQuwQJB8WTbcloBA", "PkZh41zKiUMVCrX40sx0SNoRrycBNozhTdux3LEyYI"
end
