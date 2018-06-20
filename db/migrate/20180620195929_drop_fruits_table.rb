class DropFruitsTable < ActiveRecord::Migration

  def change
    drop_table :fruits
  end

end
