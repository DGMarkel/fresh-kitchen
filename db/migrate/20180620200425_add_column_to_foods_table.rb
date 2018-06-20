class AddColumnToFoodsTable < ActiveRecord::Migration

  def change
    add_column :foods, :type, :string
  end

end
