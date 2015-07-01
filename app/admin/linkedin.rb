ActiveAdmin.register Linkedin do

  index do
    selectable_column
    id_column
    column :published
    column :bio
    column :first_name
    column :last_name
    column :email
    column :followers_count
    column :num_connections_capped
    column :location
    column :created_at
    actions
  end

  form do |f|
    inputs 'Details' do
      input :published
      input :followers_count
      input :num_connections_capped
    end
    actions
  end

  batch_action :published do |ids|
    Linkedin.find(ids).each do |linkedin|
      linkedin.published = true
      linkedin.save
    end
    redirect_to collection_path, alert: "Linkedin published"
  end
end
