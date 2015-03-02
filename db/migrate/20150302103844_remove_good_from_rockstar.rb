class RemoveGoodFromRockstar < ActiveRecord::Migration
  def change
    remove_column :rockstars, :good, :boolean
  end
end
