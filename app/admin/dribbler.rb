ActiveAdmin.register Dribbler do
  index do
    selectable_column
    id_column
    column :rank
    column :username
    column :bio
    column :followers
    column :location
    column :created_at
    actions
  end

  batch_action :rank do |ids|
    Dribbler.find(ids).each do |dribbler|
      dribbler.rank = 1
      dribbler.save
    end
    redirect_to collection_path, alert: "Dribbler published"
  end
end
