class AddRunType < ActiveRecord::Migration
  def up
    add_column :scraper_runs, :run_type, :string
    ScraperRun.update_all(:run_type => "retiring")
  end

  def down
    remove_column :scraper_runs, :run_type
  end
end
