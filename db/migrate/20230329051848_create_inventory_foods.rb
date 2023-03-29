class CreateInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_foods do |t|
      t.integer :quantity
      t.references :inventory, null: false, foriegn_key: { to_table: :inventories }
      t.references :food, null: false, foriegn_key: { to_table: :foods }
      t.timestamps
    end
  end
end
