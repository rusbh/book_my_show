require "sidekiq"
require "sidekiq/web"

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://localhost:6379/1" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379/1" }
end

# only superadmin can access "/sidekiq" path
Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  Rack::Utils.secure_compare(
    Digest::SHA256.hexdigest(user),
    Digest::SHA256.hexdigest(ENV.fetch("SUPERADMIN_USERNAME")),
  ) &
    Rack::Utils.secure_compare(
      Digest::SHA256.hexdigest(password),
      Digest::SHA256.hexdigest(ENV.fetch("SUPERADMIN_PASSWORD")),
    )
end

Sidekiq.configure_server do |config|
  config.redis = { network_timeout: 5 }
end
