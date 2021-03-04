class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :token, null: false, index: { unique: true }
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
