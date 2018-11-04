class CreateSaasSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :saas_subscriptions, id: :uuid do |t|
      t.belongs_to :plan, type: :uuid, foreign_key: { to_table: :saas_plans }
      t.uuid :subscriber_id
      t.string :subscriber_type
      t.string :stripe_customer_id
      t.string :stripe_id
      t.string :last_4

      t.timestamps
    end
    add_index :saas_subscriptions, :stripe_customer_id
    add_index :saas_subscriptions, :stripe_id
    add_index :saas_subscriptions, [:subscriber_type, :subscriber_id], name: :index_saas_subscriptions_on_subscriber
  end
end
