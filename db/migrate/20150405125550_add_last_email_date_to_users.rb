class AddLastEmailDateToUsers < ActiveRecord::Migration
  def change

    add_column :users, :last_email_date, :datetime
  end
end
