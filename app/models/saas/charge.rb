module Saas
  class Charge < ApplicationRecord
    belongs_to :subscription

    def status
      if amount_refunded_cents && amount_refunded_cents < amount_cents
        "Partial refund"
      elsif amount_refunded_cents
        "Full refund"
      else
        self[:status]
      end
    end
  end
end
