class RenameUserIdColumnToDays < ActiveRecord::Migration[5.2]
  def change
    rename_column :days, :User_id, :user_id
  end
end
