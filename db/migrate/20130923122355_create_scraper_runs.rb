class CreateScraperRuns < ActiveRecord::Migration
  def change
    create_table :scraper_runs do |t|
      t.text :html

      t.timestamps
    end
  end
end
