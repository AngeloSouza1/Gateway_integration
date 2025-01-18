class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :address
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
