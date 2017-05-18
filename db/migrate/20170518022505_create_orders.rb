class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :quantity
      t.float :subtotal
      t.float :tax
      t.float :total

      t.timestamps
    end
  end
end
