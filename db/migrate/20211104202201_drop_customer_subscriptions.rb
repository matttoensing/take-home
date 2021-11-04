class DropCustomerSubscriptions < ActiveRecord::Migration[5.2]
  def change
    drop_table :customer_subscriptions
  end
end
