module Saas
  class Subscription < ApplicationRecord
    attr_accessor :stripe_token

    belongs_to :plan
    belongs_to :subscriber, polymorphic: true

    validates :stripe_customer_id, presence: true

    before_validation :create_stripe_subscription, on: :create
    before_validation :update_stripe_subscription, on: :update

    def stripe_subscription
      @stripe_subscription ||= Stripe::Subscription.retrieve(stripe_id)
    end

    def stripe_customer
      @stripe_customer ||= Stripe::Customer.retrieve(id: stripe_customer_id, expand: ["default_source"])
    end

    def stripe_card
      case stripe_customer.default_source
      when String
        stripe_customer.sources.retrieve(stripe_customer.default_source)
      else
        stripe_customer.default_source
      end
    end

    def upcoming_invoice
      stripe_customer.upcoming_invoice
    end

    def charges
      stripe_customer.charges
    end

    private

      def create_stripe_subscription
        stripe_customer = Stripe::Customer.create(
          # TODO: require subscriber to have email and description methods. don't go through owner.
          :email => subscriber.owner.email,
          :description => subscriber.owner.name,
          :source  => stripe_token,
        )

        stripe_subscription = Stripe::Subscription.create(
          customer: stripe_customer.id,
          items: [{
            plan: plan.stripe_id
          }]
        )

        self.stripe_customer_id = stripe_customer.id
        self.stripe_id = stripe_subscription.id
        self.last_4 = stripe_card.last4
      rescue => e
        handle_exception(e)
      end

      def update_stripe_subscription
        if stripe_token
          stripe_customer.source = stripe_token
          stripe_customer.save
          self.last_4 = stripe_card.last4
        else
          stripe_subscription.items = [{
            id: stripe_subscription.items.data[0].id,
            plan: plan.stripe_id,
          }]
          stripe_subscription.save
        end
      rescue => e
        handle_exception(e)
      end

      def handle_exception(e)
        if e.is_a? Stripe::CardError
          self.errors.add :base, e.message
          self.stripe_card_token = nil
          false
        elsif e.is_a? Stripe::InvalidRequestError
          self.errors.add :base, "There was a problem with your credit card."
          false
        elsif e.is_a? Stripe::AuthenticationError
          self.errors.add :base, "There was a problem connecting to Stripe. Please try again."
          false
        elsif e.is_a? Stripe::APIConnectionError
          self.errors.add :base, "There was a problem connecting to Stripe. Please try again."
          false
        elsif e.is_a? Stripe::StripeError
          self.errors.add :base, "There was a problem processing your payment. Please try again."
          false
        else
          self.errors.add :base, "There was a problem processing your payment. Please try again."
          false
        end
      end
  end
end