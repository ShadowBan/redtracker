class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.text :description
      t.datetime :published_at
      t.timestamps
    end
  end
end
