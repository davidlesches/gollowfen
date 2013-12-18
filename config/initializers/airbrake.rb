Airbrake.configure do |config|
  config.api_key = '0eb4460627a3bcde6f1fb379daff83ad'
  config.host    = 'e.firehawkcreative.com'
  config.port    = 80
  config.secure  = config.port == 443
end
