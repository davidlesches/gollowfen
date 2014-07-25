Sidekiq.configure_server do |config|
  config.error_handlers << Proc.new { |ex, ctx_hash| Airbrake.notify(ex, ctx_hash) }
end
