class AddPictureToDribbler < ActiveRecord::Migration
  def change
    add_column :dribblers, :picture, :string, limit: 256
  end
end
