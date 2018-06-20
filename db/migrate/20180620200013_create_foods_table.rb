class CreateFoodsTable < ActiveRecord::Migration

  def change
    create_table :foods do |t|
      t.string  "name"
      t.string  "quantity"
      t.string  "expiration_date"
      t.integer "user_id"
    end
  end

end
