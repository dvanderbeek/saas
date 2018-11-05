module Saas
  class Charge < ApplicationRecord
    belongs_to :subscription

    def status
      if partial_refund?
        "Partial refund"
      elsif full_refund?
        "Full refund"
      else
        self[:status]
      end
    end

    def refunded?
      amount_refunded_cents && amount_refunded_cents > 0
    end

    def partial_refund?
      amount_refunded_cents && amount_refunded_cents > 0 && amount_refunded_cents < amount_cents
    end

    def full_refund?
      amount_refunded_cents && amount_refunded_cents == amount_cents
    end
  end
end
