module Saas
  module Stripe
    class ChargeSucceeded
      def call(event)
        puts "CHARGE SUCCEEDED: #{event}"
        # TODO: Create charge model to save details
        # https://github.com/jasoncharnes/pay/commit/4be0d0591403ce6a599b4633d00248732da5a3a7
      end
    end
  end
end
