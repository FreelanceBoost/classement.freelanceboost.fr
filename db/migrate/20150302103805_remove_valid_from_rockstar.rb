class RemoveValidFromRockstar < ActiveRecord::Migration
  def change
    remove_column :rockstars, :valid, :boolean
  end
end
