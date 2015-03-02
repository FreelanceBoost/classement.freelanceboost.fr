class CreateDribblers < ActiveRecord::Migration
  def change
    create_table :dribblers do |t|
      t.string :bio, limit: 512
      t.string :name, limit: 256
      t.integer :followers_count
      t.string :location, limit: 256

      t.timestamps
    end
  end
end
