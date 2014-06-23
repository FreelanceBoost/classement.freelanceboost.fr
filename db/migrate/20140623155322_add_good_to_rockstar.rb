class AddGoodToRockstar < ActiveRecord::Migration
  def change
    add_column :rockstars, :good, :boolean
  end
end
