class AddSpecsToItem < ActiveRecord::Migration
  def change
    add_column :items, :specs, :string
  end
end
