class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :borrower_id, :integer
    add_column :orders, :lessor_id, :integer
  end
end
