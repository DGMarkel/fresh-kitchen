class DropPantryItemsTable < ActiveRecord::Migration

  def change
    drop_table :pantry_items
  end

end
