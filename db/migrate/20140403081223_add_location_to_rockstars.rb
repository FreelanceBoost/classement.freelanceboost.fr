class AddLocationToRockstars < ActiveRecord::Migration
  def change
    add_column :rockstars, :location, :string
  end
end
