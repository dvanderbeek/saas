module Saas
  class Plan < ApplicationRecord
    belongs_to :product, counter_cache: true

    delegate :name, to: :product, prefix: true

    def identifier
      "#{product_name} - #{name}"
    end
  end
end
