module Saas
  module Stripe
    class ChargeRefunded
      def call(event)
        puts "Charge refunded #{event}"
        # TODO: Update amount refunded on charge model once it exists
        # https://github.com/jasoncharnes/pay/commit/4be0d0591403ce6a599b4633d00248732da5a3a7
      end
    end
  end
end
