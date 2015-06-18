class CreateGithubers < ActiveRecord::Migration
  def change
    create_table :githubers do |t|
      t.string :bio, limit: 512
      t.string :name, limit: 256
      t.integer :followers_count
      t.string :location, limit: 256
      t.boolean :published
      t.string :company, limit: 256
      t.integer :rank
      t.string :avatar_url, limit: 256
      t.string :location, limit: 256
      t.string :blog, limit: 256
      t.string :github_login, limit: 64
      t.string :github_type, limit: 64
      t.string :email, limit: 256
      t.integer :following_count
      t.integer :public_repo
      t.integer :public_gist
      t.boolean :hireable
      t.integer :github_id
      t.datetime :github_updated_at
      t.datetime :github_created_at

      t.timestamps null: false
    end
  end
end
