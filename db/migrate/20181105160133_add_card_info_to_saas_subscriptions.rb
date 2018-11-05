class AddCardInfoToSaasSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :saas_subscriptions, :card_brand, :string
    add_column :saas_subscriptions, :card_exp_month, :string
    add_column :saas_subscriptions, :card_exp_year, :string
  end
end
