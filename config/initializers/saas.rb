env = Rails.env.production? ? :production : :development
rails_config = Rails.application.credentials[env]

if rails_config && rails_config[:stripe]
  Saas.configure do |config|
    config.stripe_public_key = rails_config[:stripe][:public_key]
    config.stripe_secret_key = rails_config[:stripe][:secret_key]
    config.stripe_signing_secret = rails_config[:stripe][:signing_secret]
    config.stripe_subscriber_class_name = "Customer"
  end

  StripeEvent.configure do |events|
    events.subscribe 'checkout.session.completed', Saas::Stripe::CheckoutSessionCompleted.new
    events.subscribe 'customer.subscription.updated', Saas::Stripe::SubscriptionUpdated.new
  end
end
