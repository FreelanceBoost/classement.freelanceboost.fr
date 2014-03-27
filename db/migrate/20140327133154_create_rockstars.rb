class CreateRockstars < ActiveRecord::Migration
  def change
    create_table :rockstars do |t|
      t.string :pseudo
      t.text :desc
      t.text :url_img
      t.integer :rank

      t.timestamps
    end
  end
end
