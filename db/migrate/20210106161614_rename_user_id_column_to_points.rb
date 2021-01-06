class RenameUserIdColumnToPoints < ActiveRecord::Migration[5.2]
  def change
    rename_column :points, :User_id, :user_id
  end
end
