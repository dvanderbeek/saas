module Saas
  module ApplicationHelper
    def date_from_stripe_timestamp(timestamp)
      Time.at(timestamp).strftime("%Y-%m-%d")
    end
  end
end
