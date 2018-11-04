module Saas
  class SubscriptionsController < Saas::ApplicationController
    before_action :authenticate_user!

    # TODO: remove current_user.account, add authorization
    def edit
      if @subscription = Subscription.find_by(subscriber: current_user.account)
        @upcoming     = @subscription.upcoming_invoice
        @charges      = @subscription.charges
      else
        @subscription = Subscription.new(subscriber: current_user.account)
      end
    end

    def create
      @subscription = Subscription.new(subscription_params)
      @subscription.stripe_token = params[:stripeToken]
      @subscription.subscriber = current_user.account

      if @subscription.save
        redirect_to [:edit, :subscription], notice: 'Subscription was successfully created.'
      else
        render :edit
      end
    end

    def update
      @subscription = Subscription.find_by(subscriber: current_user.account)
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
