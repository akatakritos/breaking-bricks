class RenameSraperRunId < ActiveRecord::Migration
  def up
    rename_column :scraper_results, :scraper_run, :scraper_run_id
  end

  def down
    rename_column :scraper_results, :scraper_run_id, :scraper_run
  end
end
