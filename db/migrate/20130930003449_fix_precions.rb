class FixPrecions < ActiveRecord::Migration
  def up
    change_column :scraper_results, :was_price, :decimal, :precision => 6, :scale => 2
    change_column :scraper_results, :now_price, :decimal, :precision => 6, :scale => 2
  end

  def down
  end
end
