class RemovePaymentUserTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_payments
  end
end
