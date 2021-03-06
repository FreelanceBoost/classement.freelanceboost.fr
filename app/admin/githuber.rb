ActiveAdmin.register Githuber do

  index do
    selectable_column
    id_column
    column :published
    column :github_login
    column :name
    column :email
    column :company
    column :followers_count
    column :location
    column :created_at
    actions
  end

  batch_action :published do |ids|
    Githuber.find(ids).each do |githuber|
      githuber.published = true
      githuber.save
    end
    redirect_to collection_path, alert: "Githuber published"
  end

end
