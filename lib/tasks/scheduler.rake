desc "This task is called by the Heroku scheduler add-on"
task :update_tweet => :environment do

  puts "Updating Tweeter / Dribbbler / GitHub / LinkedIn accounts..."

  twitter = RockstarsController.new
  twitter.update()

  dribbler = DribbblersController.new
  dribbler.update()

  githuber = GithubersController.new
  githuber.update()

  puts "done."
end
