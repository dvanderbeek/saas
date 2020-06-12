class AddCancelAtToSaasSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :saas_subscriptions, :cancel_at, :datetime
  end
end
