class AddColumnSearchNameToBands < ActiveRecord::Migration
  def change
     add_column :bands, :search_name, :string
  end
end
