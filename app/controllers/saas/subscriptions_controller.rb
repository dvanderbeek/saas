module Saas
  class SubscriptionsController < Saas::ApplicationController
    before_action :authenticate_user!
    before_action :load_subscription, only: [:edit, :cancel, :resume]

    def edit
      if @subscription && @subscription.stripe_subscription.status == "active"
        @upcoming = @subscription.upcoming_invoice
      else
        redirect_to pricing_index_path
      end
    end

    def create
      @subscription = Subscription.new(subscription_params)
      @subscription.stripe_token = params[:stripeToken]
      @subscription.subscriber = current_subscriber

      if @subscription.save
        redirect_to [:edit, :subscription], notice: 'Subscription was successfully created.'
      else
        render :edit
      end
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
        @subscription = Subscription.find_by(subscriber: current_subscriber)
      end
  end
end
