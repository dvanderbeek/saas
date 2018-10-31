module Saas
  class PricingController < ApplicationController
    def index
      @products = Product.includes(:plans).all
    end
  end
end
