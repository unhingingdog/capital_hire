class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.string :category
      t.integer :rate

      t.timestamps null: false
    end
  end
end
