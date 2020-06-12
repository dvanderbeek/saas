class AddStatusToSaasSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :saas_subscriptions, :status, :string
  end
end
