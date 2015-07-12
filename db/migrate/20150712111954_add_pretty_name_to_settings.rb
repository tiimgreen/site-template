class AddPrettyNameToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :pretty_name, :string
  end
end
