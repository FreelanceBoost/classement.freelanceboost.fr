class AddFollowersToDribbler < ActiveRecord::Migration
  def change
    add_column :dribblers, :followers, :int
  end
end
