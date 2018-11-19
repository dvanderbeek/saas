module Saas
  class Plan < ApplicationRecord
    belongs_to :product, counter_cache: true

    def identifier
      "#{product.name} - #{name}"
    end
  end
end
