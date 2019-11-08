class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :item, foreign_key: true
      t.references :payment, foreign_key: true
      t.integer :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
