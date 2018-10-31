module Saas
  class Product < ApplicationRecord
    has_many :plans
  end
end
