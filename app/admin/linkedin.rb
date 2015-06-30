ActiveAdmin.register Linkedin do

index do
    selectable_column
    id_column
    column :published
    column :linkedin_id
    column :first_name
    column :last_name
    column :email
    column :followers_count
    column :num_connections_capped
    column :location
    column :created_at
    actions
  end

  batch_action :published do |ids|
    Linkedin.find(ids).each do |githuber|
      githuber.published = true
      githuber.save
    end
    redirect_to collection_path, alert: "Linkedin published"
  end


end
