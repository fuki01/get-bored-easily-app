class AddClearToTarget < ActiveRecord::Migration[5.2]
  def change
    add_column :targets, :clear, :boolean
  end
end
