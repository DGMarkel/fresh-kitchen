class CreatePantryItems < ActiveRecord::Migration

  def change
    create_table :pantry_items do |t|
      t.string :name
      t.string :quantity
      t.string :expiration_date
      t.integer :user_id
    end
  end

end
