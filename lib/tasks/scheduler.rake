desc "This task is called by the Heroku scheduler add-on"
task :update_tweet => :environment do

  puts "Updating Tweeter / Dribbbler / GitHub / LinkedIn accounts..."

  githuber = GithubersController.new
  githuber.update()

  twitter = RockstarsController.new
  twitter.update()

  dribbler = DribbblersController.new
  dribbler.update()

  linkedin = LinkedinController.new
  linkedin.update()

  puts "done."
end
