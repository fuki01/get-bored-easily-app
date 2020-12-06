class AddUserIdToPoint < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :User_id, :int
  end
end
