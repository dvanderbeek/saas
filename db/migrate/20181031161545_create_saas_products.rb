class CreateSaasProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :saas_products, id: :uuid do |t|
      t.string :name
      t.string :stripe_id
      t.string :statement_descriptor
      t.string :unit_label

      t.timestamps
    end
  end
end
