class CreateLinkedins < ActiveRecord::Migration
  def change
    create_table :linkedins do |t|
      t.string :bio, limit: 512
      t.string :first_name, limit: 256
      t.string :last_name
      t.integer :followers_count
      t.string :location, limit: 256
      t.boolean :published
      t.integer :rank
      t.string :avatar_url, limit: 256
      t.string :location, limit: 256
      t.string :blog, limit: 256
      t.string :email, limit: 256
      t.string :linkedin_id, limit: 256

      t.timestamps null: false
    end
  end
end
