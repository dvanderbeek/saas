module Saas
  class PricingController < Saas::ApplicationController
    def index
      @products = Product.includes(:plans).all
    end
  end
end
