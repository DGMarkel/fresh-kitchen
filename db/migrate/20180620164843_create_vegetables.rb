class CreateVegetables < ActiveRecord::Migration[5.2]

  def change
    create_table :vegetables do |t|
      t.string :name
      t.string :quantity
      t.string :expiration_date
      t.integer :user_id
  end

end
