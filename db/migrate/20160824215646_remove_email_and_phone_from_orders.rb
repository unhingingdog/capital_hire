class RemoveEmailAndPhoneFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :email, :string
    remove_column :orders, :phone, :string
  end
end
