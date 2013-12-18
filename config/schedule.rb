
env :PATH, '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'

every 15.minutes do
  runner 'Cronbaby.run_favorites'
end

every 1.day do
  runner 'Cronbaby.import_followers'
end