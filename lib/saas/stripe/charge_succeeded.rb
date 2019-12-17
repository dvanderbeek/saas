module Saas
  module Stripe
    class ChargeSucceeded
      def call(event)
        object = event.data.object
        subscription = ::Saas::Subscription.find_by(stripe_customer_id: object.customer)

        return if subscription.nil?
        return if subscription.charges.where(stripe_id: object.id).any?

        subscription.charges.create(
          stripe_id: object.id,
          amount_cents: object.amount,
          amount_refunded_cents: object.amount_refunded,
          status: object.status,
          created_at: Time.zone.at(object.created),
          card_brand: object.source.brand,
          card_last_4: object.source.last4,
          card_exp_month: object.source.exp_month,
          card_exp_year: object.source.exp_year,
        )
      end
    end
  end
end
