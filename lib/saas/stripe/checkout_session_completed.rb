module Saas
  module Stripe
    class CheckoutSessionCompleted
      def call(event)
        object = event.data.object

        subscriber_class = ::Saas.stripe_subscriber_class_name.safe_constantize
        subscriber = subscriber_class.find(object.client_reference_id)

        ss   = ::Stripe::Subscription.retrieve(object.subscription)
        plan = ::Saas::Plan.find_by(stripe_id: ss.plan.id)
        pm   = ::Stripe::PaymentMethod.list(customer: object.customer, type: "card").first

        sub = Subscription.new(
          subscriber: subscriber,
          stripe_id: object.subscription,
          stripe_customer_id: object.customer,
          plan: plan,
          last_4: pm.card.last4,
          card_brand: pm.card.brand,
          card_exp_month: pm.card.exp_month,
          card_exp_year: pm.card.exp_year,
          status: ss.status
        )
        sub.save
      end
    end
  end
end
