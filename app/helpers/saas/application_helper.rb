module Saas
  module ApplicationHelper
    def date_from_stripe_timestamp(timestamp)
      Time.at(timestamp).strftime("%Y-%m-%d")
    end

    def interval_display(interval)
      case interval
        when "day"   then "Daily"
        when "week"  then "Weekly"
        when "month" then "Monthly"
        when "year"  then "Annual"
        else ""
      end
    end
  end
end
