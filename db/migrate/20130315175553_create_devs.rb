class CreateDevs < ActiveRecord::Migration
  def change
    create_table :devs do |t|
      t.string :name
      t.string :username

      t.timestamps
    end
  end
end
