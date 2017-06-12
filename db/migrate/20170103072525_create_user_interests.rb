class CreateUserInterests < ActiveRecord::Migration[4.2]
  def change
    create_table :user_interests do |t|
      t.integer :user_id, :interest_id
      t.timestamps
    end
  end
end
