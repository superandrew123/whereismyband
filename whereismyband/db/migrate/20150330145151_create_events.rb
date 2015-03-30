class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      # location represents the name
      # Or location of a show
      t.string :location
      t.datetime :start_time
      t.string :link
      t.integer :band_id
      t.timestamps null: false
    end
  end
end
