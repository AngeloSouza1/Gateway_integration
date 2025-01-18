class CreateMegapayConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :megapay_configs do |t|
      t.boolean :active, default: true
      t.boolean :capture, default: false
      t.datetime :deleted_at
      t.boolean :has_rate, default: false
      t.integer :installments
      t.string :name
      t.string :name_invoice
      t.decimal :rate, precision: 19, scale: 2
      t.string :public_key
      t.string :secret_key
      t.string :production_url, default: 'https://api.megapay.com'
      t.string :sandbox_url, default: 'https://sandbox.api.megapay.com'
      t.string :slug
      t.string :statement_descriptor
      t.references :client, null: true, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.timestamps
    end

    add_column :clients, :has_megapay, :boolean, default: false
  end
end
