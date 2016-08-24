class AddUseToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :use, :string
  end
end
