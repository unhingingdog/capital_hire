class DropOrders < ActiveRecord::Migration
  def change
    drop_table :orders, force: :cascade
    drop_table :order_statuses, force: :cascade
    drop_table :order_items, force: :cascade
  end
end
