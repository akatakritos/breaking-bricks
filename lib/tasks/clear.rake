namespace :clear do
  desc "Clears the last run's results"
  task :last_run => :environment do
    ScraperRun.last.scraper_results.delete_all
  end
end
