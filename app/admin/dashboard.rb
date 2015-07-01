ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    div class: "blank_slate_container", id: "dashboard_default_message" do
        panel "New Rockstars" do
          ul do
            Rockstar.where(rank: 0).map do |star|
              li link_to(star.pseudo, admin_rockstar_path(star))
            end
          end
        end
        panel "New Dribbblers" do
          ul do
            Dribbler.where(rank: 0).map do |dribbler|
              li link_to(dribbler.username, admin_dribbler_path(dribbler))
            end
          end
        end
        panel "New Githubers" do
          ul do
            Githuber.where(published: false).map do |githuber|
              li link_to(githuber.name, admin_githuber_path(githuber))
            end
          end
        end
        panel "New LinkedIn" do
          ul do
            Linkedin.where(published: false).map do |linkedin|
              li link_to(linkedin.last_name, admin_linkedin_path(linkedin))
            end
          end
        end
    end
  end # content
end
