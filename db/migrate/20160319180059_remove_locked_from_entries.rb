class RemoveLockedFromEntries < ActiveRecord::Migration
  def change
    remove_column :entries, :locked, :boolean
  end
end
