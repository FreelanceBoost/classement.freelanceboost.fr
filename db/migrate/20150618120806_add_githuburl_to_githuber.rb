class AddGithuburlToGithuber < ActiveRecord::Migration
  def change
    add_column :githubers, :githuburl, :string, limit: 256
  end
end
