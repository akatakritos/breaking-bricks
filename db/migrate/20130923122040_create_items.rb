class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :code
      t.string :name
      t.string :page
      t.string :image

      t.timestamps
    end
  end
end
