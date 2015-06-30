class AddLinkedinUrlToLinkedin < ActiveRecord::Migration
  def change
    add_column :linkedins, :linkedin_url, :string, limit: 256
  end
end
