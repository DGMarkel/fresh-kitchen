class DropMeatsTable < ActiveRecord::Migration

  def change
    drop_table :meats
  end

end
