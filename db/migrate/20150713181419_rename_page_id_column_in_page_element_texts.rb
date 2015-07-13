class RenamePageIdColumnInPageElementTexts < ActiveRecord::Migration
  def change
    rename_column :page_element_texts, :page_id, :web_page_id
  end
end
