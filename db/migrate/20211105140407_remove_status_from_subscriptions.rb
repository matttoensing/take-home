class RemoveStatusFromSubscriptions < ActiveRecord::Migration[5.2]
  def change
    remove_column :subscriptions, :status
    add_column :subscriptions, :status, :integer, default: 0
  end
end
