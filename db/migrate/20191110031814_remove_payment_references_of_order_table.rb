class RemovePaymentReferencesOfOrderTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :payment_id
  end
end
