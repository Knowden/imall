class DropHistoryOrdersTb < ActiveRecord::Migration[5.2]
  def change
    drop_table :history_orders
  end
end
