class CreateSaasFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :saas_features, id: :uuid do |t|
      t.integer :position
      t.belongs_to :product, null: false, type: :uuid, foreign_key: { to_table: :saas_products, on_delete: :cascade }
      t.string :description

      t.timestamps
    end
  end
end
