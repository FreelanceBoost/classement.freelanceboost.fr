desc "This task is called by the Heroku scheduler add-on"
task :update_tweet => :environment do
  puts "Updating tweeter account..."
  ctrl = RockstarsController.new
  ctrl.update()
  puts "done."
end