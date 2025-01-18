class CreateGateways < ActiveRecord::Migration[7.2]
  def change
    create_table :gateways do |t|
      t.string :name
      t.boolean :active
      t.string :production_url
      t.string :sandbox_url
      t.string :public_key
      t.string :secret_key
      t.decimal :rate

      t.timestamps
    end
  end
end
