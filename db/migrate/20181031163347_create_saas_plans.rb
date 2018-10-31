class CreateSaasPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :saas_plans do |t|
      t.belongs_to :product, foreign_key: { to_table: :saas_products }
      t.string :name
      t.string :stripe_id
      t.integer :price_in_cents
      t.string :interval
      t.integer :trial_period

      t.timestamps
    end
  end
end
