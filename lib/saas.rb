require "saas/engine"
require "stripe"

module Saas
  mattr_accessor :stripe_secret_key, :stripe_public_key

  def self.configure
    yield self
  end

  def self.stripe_secret_key=(key)
    @@stripe_secret_key = ::Stripe.api_key = key
  end
end
