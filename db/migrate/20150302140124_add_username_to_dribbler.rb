class AddUsernameToDribbler < ActiveRecord::Migration
  def change
    add_column :dribblers, :username, :string, limit: 256
  end
end
