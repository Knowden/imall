class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content
      t.date :create_date

      t.timestamps
    end
  end
end
