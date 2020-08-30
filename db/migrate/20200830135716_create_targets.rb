class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.text    :body
      t.integer :user_id
      t.timestamps
    end
  end
end
