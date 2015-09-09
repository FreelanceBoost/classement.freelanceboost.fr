desc "This task is called by the Heroku scheduler add-on"
task :update_tweet => :environment do

  puts "Updating Tweeter / Dribbbler / GitHub / LinkedIn accounts..."

  puts " GitHub =>"
  githuber = GithubersController.new
  githuber.update()
  puts "<= GitHub"

  puts "twitter =>"
  twitter = RockstarsController.new
  twitter.update()
  puts "<= twitter"
  
  puts " dribbler =>"
  dribbler = DribbblersController.new
  dribbler.update()
  puts "<= dribbler"
  
  puts " linkedin =>"
  linkedin = LinkedinController.new
  linkedin.update()
  puts "<= linkedin"
  
  puts "GitHub =>"
  ranking = RankingController.new
  ranking.calculate_rank()
  puts "<=GitHub"

  puts "done."
end
