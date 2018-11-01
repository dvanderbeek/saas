class CreateSaasAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :saas_accounts, id: :uuid do |t|
      t.string :name
      t.uuid :owner_id

      t.timestamps
    end
  end
end
