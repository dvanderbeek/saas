class ChangeChargesStripeIdToString < ActiveRecord::Migration[5.2]
  def change
    change_column :saas_charges, :stripe_id, :string
  end
end
