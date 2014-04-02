class AddNameToRockstars < ActiveRecord::Migration
  def change
    add_column :rockstars, :name, :string
  end
end
