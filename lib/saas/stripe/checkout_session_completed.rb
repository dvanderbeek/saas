module Saas
  module Stripe
    class CheckoutSessionCompleted
      def call(event)
        object = event.data.object
        # user = ::User.find_by(email: object.customer_email)
        # account = user.account
        # TODO: Probably need a configuration setting for subscriber class. It's not necessarily Account
        account = ::Account.find(object.client_reference_id)

        ss   = ::Stripe::Subscription.retrieve(object.subscription)
        plan = ::Saas::Plan.find_by(stripe_id: ss.plan.id)
        pm   = ::Stripe::PaymentMethod.list(customer: object.customer, type: "card").first

        sub = Subscription.new(
          subscriber: account,
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
        # subscription = ::Saas::Subscription.find_by(stripe_customer_id: object.customer)
        #
        # return if subscription.nil?
        # return if subscription.charges.where(stripe_id: object.id).any?
        #
        # subscription.charges.create(
        #   stripe_id: object.id,
        #   amount_cents: object.amount,
        #   amount_refunded_cents: object.amount_refunded,
        #   status: object.status,
        #   created_at: Time.zone.at(object.created),
        #   card_brand: object.source.brand,
        #   card_last_4: object.source.last4,
        #   card_exp_month: object.source.exp_month,
        #   card_exp_year: object.source.exp_year,
        # )
      end
    end
  end
end
