class RemovePossibleFromDays < ActiveRecord::Migration[5.2]
  def change
    remove_column :days, :possible, :boolean
  end
end
