module Saas
  class SubscriptionsController < Saas::ApplicationController
    before_action :authenticate_user!

    def edit
      if @subscription = Subscription.includes(:charges).find_by(subscriber: current_subscriber)
        @upcoming = @subscription.upcoming_invoice
      else
        @subscription = Subscription.new(subscriber: current_subscriber)
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
      @subscription = Subscription.includes(:charges).find_by(subscriber: current_subscriber)
      @subscription.stripe_token = params[:stripeToken]

      if @subscription.update(subscription_params)
        redirect_to [:edit, :subscription], notice: 'Subscription was successfully updated.'
      else
        render :edit
      end
    end

    private

      def subscription_params
        params.fetch(:subscription, {}).permit(:plan_id, :stripe_token)
      end
  end
end
