class AddNumConnectionsCappedToLinkedin < ActiveRecord::Migration
  def change
    add_column :linkedins, :num_connections_capped, :boolean
  end
end
