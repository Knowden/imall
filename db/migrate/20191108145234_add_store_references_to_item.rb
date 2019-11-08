class AddStoreReferencesToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :store, foreign_key: true
  end
end
