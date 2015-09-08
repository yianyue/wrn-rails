class AddLockedToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :locked, :boolean
  end
end
