module Saas
  module Stripe
    class SubscriptionUpdated
      def call(event)
        object = event.data.object
        subscription = Saas::Subscription.find_by(stripe_id: object.id)

        plan = Saas::Plan.find_by(stripe_id: object.items.data[0].price.id)
        cancel_at = Time.at(object.cancel_at) if object.cancel_at.present?

        subscription.update(
          plan: plan,
          status: object.status,
          cancel_at: cancel_at
        )
      end
    end
  end
end
