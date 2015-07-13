class CreateWebPages < ActiveRecord::Migration
  def change
    create_table :web_pages do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
