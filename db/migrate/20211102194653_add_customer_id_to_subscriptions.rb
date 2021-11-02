class AddCustomerIdToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :subscriptions, :customer, index: true
    add_foreign_key :subscriptions, :customers
  end
end
