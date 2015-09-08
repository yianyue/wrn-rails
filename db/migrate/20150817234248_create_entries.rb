class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :content
      t.integer :word_count
      t.integer :goal

      t.timestamps null: false
    end
  end
end
