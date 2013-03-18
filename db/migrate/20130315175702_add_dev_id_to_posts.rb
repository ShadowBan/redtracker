class AddDevIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :dev_id, :integer
    add_index :posts, :dev_id
  end
end
