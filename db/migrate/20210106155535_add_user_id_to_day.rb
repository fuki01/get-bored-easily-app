class AddUserIdToDay < ActiveRecord::Migration[5.2]
  def change
    add_column :days, :User_id, :integer
  end
end
