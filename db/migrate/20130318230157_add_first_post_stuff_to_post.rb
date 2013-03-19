class AddFirstPostStuffToPost < ActiveRecord::Migration
  def change
    add_column :posts, :fp_username, :string
    add_column :posts, :fp_description, :text
  end
end
