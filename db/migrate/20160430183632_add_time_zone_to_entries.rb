class AddTimeZoneToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :time_zone, :string
  end
end
