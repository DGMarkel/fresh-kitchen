class DropVegetablesTable < ActiveRecord::Migration

  def change
    drop_table :vegetables
  end
  
end
