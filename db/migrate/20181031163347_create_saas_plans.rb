class CreateSaasPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :saas_plans, id: :uuid do |t|
      t.belongs_to :product, type: :uuid, foreign_key: { to_table: :saas_products }
      t.string :name
      t.string :stripe_id
      t.integer :price_in_cents
      t.string :interval
      t.integer :trial_period

      t.timestamps
    end
  end
end
