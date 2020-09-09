require "saas/engine"
require "stripe"
require "stripe_event"
require "saas/stripe/charge_succeeded"
require "saas/stripe/charge_refunded"
require "saas/stripe/checkout_session_completed"
require "saas/stripe/subscription_updated"
require "saas/stripe/subscription_deleted"

module Saas
  mattr_accessor :stripe_secret_key,
                 :stripe_public_key,
                 :stripe_signing_secret,
                 :stripe_subscriber_class_name,
                 :app_name

  def self.configure
    yield self
  end

  def self.stripe_secret_key=(key)
    @@stripe_secret_key = ::Stripe.api_key = key
  end

  def self.stripe_signing_secret=(secret)
    @@stripe_signing_secret = ::StripeEvent.signing_secret = secret
  end
end
