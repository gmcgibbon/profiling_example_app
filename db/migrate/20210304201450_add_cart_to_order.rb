class AddCartToOrder < ActiveRecord::Migration[6.1]
  def change
    change_table :orders do |t|
      t.references :cart, null: false
    end
  end
end
