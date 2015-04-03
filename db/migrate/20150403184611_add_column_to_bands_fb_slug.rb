class AddColumnToBandsFbSlug < ActiveRecord::Migration
  def change
    add_column :bands, :fb_slug, :string
  end
end
