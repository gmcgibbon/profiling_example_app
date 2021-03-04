class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false
      t.references :product, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
