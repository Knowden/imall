class CreateHistoryOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :history_orders do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :amount
      t.date :finish_date

      t.timestamps
    end
  end
end
