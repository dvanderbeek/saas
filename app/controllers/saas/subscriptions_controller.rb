module Saas
  class SubscriptionsController < Saas::ApplicationController
    before_action :authenticate_user!
    before_action :load_subscription, only: [:edit, :cancel, :resume]

    def edit
      if @subscription && @subscription.active?
        # @upcoming = @subscription.upcoming_invoice
        session = ::Stripe::BillingPortal::Session.create({
          customer: @subscription.stripe_customer_id,
          return_url: main_app.root_url,
        })
        redirect_to session.url
      else
        redirect_to pricing_index_path
      end
    end

    def create
      plan = Saas::Plan.find(params[:subscription][:plan_id])

      attrs = {
        customer_email: current_subscriber.email,
        payment_method_types: ['card'],
        line_items: [{
          price: plan.stripe_id,
          quantity: 1,
        }],
        subscription_data: {},
        mode: 'subscription',
        success_url: "#{edit_subscription_url}?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: edit_subscription_url,
        client_reference_id: current_subscriber.id,
        allow_promotion_codes: true
      }
      attrs[:subscription_data][:coupon] = params[:subscription][:coupon_code] if params[:subscription][:coupon_code].present?

      @session = ::Stripe::Checkout::Session.create(attrs)
    end

    def update
      @subscription = Subscription.find_by(subscriber: current_subscriber)
      @subscription.stripe_token = params[:stripeToken]

      if @subscription.update(subscription_params)
        redirect_to [:edit, :subscription], notice: 'Subscription was successfully updated.'
      else
        render :edit
      end
    end

    def cancel
      stripe_subscription = @subscription.stripe_subscription
      stripe_subscription.cancel_at_period_end = true
      stripe_subscription.save
      redirect_to edit_subscription_path, notice: 'Subscription was successfully set for cancellation.'
    end

    def resume
      stripe_subscription = @subscription.stripe_subscription
      stripe_subscription.cancel_at_period_end = false
      stripe_subscription.save
      redirect_to edit_subscription_path, notice: 'Subscription was successfully resumed.'
    end

    private

      def subscription_params
        params.fetch(:subscription, {}).permit(:plan_id, :stripe_token, :coupon_code)
      end

      def load_subscription
        @subscription = Subscription.active.find_by(subscriber: current_subscriber)
      end
  end
end
