ActiveAdmin.register Rockstar do

index do
    selectable_column
    id_column
    column :rank
    column :pseudo
    column :location
    column :created_at
    actions
  end

  batch_action :rank do |ids|
    Rockstar.find(ids).each do |rockstar|
      rockstar.rank = 1
      rockstar.save
    end
    redirect_to collection_path, alert: "Rockstar published"
  end
end
