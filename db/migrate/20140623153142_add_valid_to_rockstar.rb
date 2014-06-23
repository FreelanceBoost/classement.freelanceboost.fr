class AddValidToRockstar < ActiveRecord::Migration
  def change
    add_column :rockstars, :valid, :boolean
  end
end
