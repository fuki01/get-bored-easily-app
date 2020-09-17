class AddEntrydayToDay < ActiveRecord::Migration[5.2]
  def change
    add_column :days, :entryday, :date
  end
end
