module Saas
  class PricingController < Saas::ApplicationController
    def index
      @plans_by_interval = Plan.includes(:product)
                               .order(price_in_cents: :asc)
                               .group_by(&:interval)
    end
  end
end
