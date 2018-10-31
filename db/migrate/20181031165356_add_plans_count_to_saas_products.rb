class AddPlansCountToSaasProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :saas_products, :plans_count, :integer, default: 0
  end
end
