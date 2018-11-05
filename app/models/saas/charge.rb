module Saas
  class Charge < ApplicationRecord
    belongs_to :subscription
  end
end
