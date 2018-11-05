module Saas
  module Stripe
    class ChargeRefunded
      def call(event)
        object = event.data.object
        charge = ::Saas::Charge.find_by(stripe_id: object.id)
        
        return unless charge.present?
        
        charge.update(amount_refunded_cents: object.amount_refunded)
      end
    end
  end
end
