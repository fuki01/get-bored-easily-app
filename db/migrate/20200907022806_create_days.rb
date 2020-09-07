class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.boolean :possible
      t.integer :count
      t.integer :target_id

      t.timestamps
    end
  end
end
