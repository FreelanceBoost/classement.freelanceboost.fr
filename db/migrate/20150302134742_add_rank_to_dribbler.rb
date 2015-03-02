class AddRankToDribbler < ActiveRecord::Migration
  def change
    add_column :dribblers, :rank, :int
  end
end
