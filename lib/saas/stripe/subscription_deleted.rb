module Saas
  module Stripe
    class SubscriptionDeleted
      def call(event)
        object = event.data.object
        subscription = Saas::Subscription.find_by(stripe_id: object.id)

        return if subscription.nil?
        
        subscription.update(
          status: object.status
        )
      end
    end
  end
end
