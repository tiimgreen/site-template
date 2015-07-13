class CreatePageElementTexts < ActiveRecord::Migration
  def change
    create_table :page_element_texts do |t|
      t.integer :page_id
      t.string :key
      t.text :value

      t.timestamps null: false
    end
  end
end
