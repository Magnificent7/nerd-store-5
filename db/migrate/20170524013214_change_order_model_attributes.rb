class ChangeOrderModelAttributes < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :product_id, :integer
    remove_column :orders, :quantity, :integer
    add_column :orders, :completed, :boolean
  end
end
