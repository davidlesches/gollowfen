Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, CONFIG[:twitter_key], CONFIG[:twitter_secret]
end