class DropBeveragesTable < ActiveRecord::Migration

  def change
    drop_table :beverages
  end

end
