module Saas
  class Plan < ApplicationRecord
    belongs_to :product, counter_cache: true
  end
end
