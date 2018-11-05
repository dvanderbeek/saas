class AddStatusToSaasCharges < ActiveRecord::Migration[5.2]
  def change
    add_column :saas_charges, :status, :string
  end
end
