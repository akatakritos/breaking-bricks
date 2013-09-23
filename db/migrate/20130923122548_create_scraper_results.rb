class CreateScraperResults < ActiveRecord::Migration
  def change
    create_table :scraper_results do |t|
      t.integer :scraper_run
      t.integer :item_id
      t.decimal :was_price
      t.decimal :now_price
      t.string :availability
      t.string :availability_text

      t.timestamps
    end
  end
end
