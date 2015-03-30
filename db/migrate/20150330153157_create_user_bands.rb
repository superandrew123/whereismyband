class CreateUserBands < ActiveRecord::Migration
  def change
    create_table :user_bands do |t|
      t.integer :user_id
      t.integer :band_id
      t.timestamps null: false
    end
  end
end
