module Saas
  class PricingController < Saas::ApplicationController
    def index
      @plans_by_interval = Plan.includes(product: :features)
                               .order(price_in_cents: :asc)
                               .group_by(&:interval)

      @subscription = Subscription.active.includes(:charges).find_by(subscriber: current_subscriber) ||
                        Subscription.new(subscriber: current_subscriber)
    end
  end
end
