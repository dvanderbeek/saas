class CreateSaasCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :saas_charges, id: :uuid do |t|
      t.belongs_to :subscription, type: :uuid, foreign_key: { to_table: :saas_subscriptions }
      t.integer :stripe_id
      t.integer :amount_cents
      t.integer :amount_refunded_cents
      t.string :card_brand
      t.string :card_last_4
      t.string :card_exp_month
      t.string :card_exp_year

      t.timestamps
    end
    add_index :saas_charges, :stripe_id
  end
end
