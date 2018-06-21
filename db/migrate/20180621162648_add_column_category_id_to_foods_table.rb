class AddColumnCategoryIdToFoodsTable < ActiveRecord::Migration

  def change
    add_column :foods, :category_id, :integer
  end
end
