class AddPreviewToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :preview, :string
  end
end
