Saas.configure do |config|
  config.stripe_public_key = Rails.application.credentials.stripe[:public_key]
  config.stripe_secret_key = Rails.application.credentials.stripe[:secret_key]
end