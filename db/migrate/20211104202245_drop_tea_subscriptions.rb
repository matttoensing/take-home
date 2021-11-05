class DropTeaSubscriptions < ActiveRecord::Migration[5.2]
  def change
    drop_table :tea_subscriptions
  end
end
