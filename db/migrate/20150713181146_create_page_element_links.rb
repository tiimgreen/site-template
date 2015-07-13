class CreatePageElementLinks < ActiveRecord::Migration
  def change
    create_table :page_element_links do |t|
      t.integer :web_page_id
      t.string :key
      t.string :text
      t.string :link

      t.timestamps null: false
    end
  end
end
