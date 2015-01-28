class AddFollowercountToRockstar < ActiveRecord::Migration
  def change
    add_column :rockstars, :follower_count, :integer
  end
end
