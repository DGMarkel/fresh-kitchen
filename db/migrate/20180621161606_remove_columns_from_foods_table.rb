class RemoveColumnsFromFoodsTable < ActiveRecord::Migration

  def change
    remove_column :foods, :user_id
    remove_column :foods, :category
  end

end
