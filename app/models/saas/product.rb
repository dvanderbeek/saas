module Saas
  class Product < ApplicationRecord
    has_many :plans
    has_many :features, dependent: :destroy
  end
end
