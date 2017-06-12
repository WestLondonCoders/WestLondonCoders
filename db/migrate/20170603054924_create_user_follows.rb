class CreateUserFollows < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :user_follows do |t|
      t.references :follower, references: :user, null: false
      t.references :user, references: :user

      t.timestamps null: false
    end
  end
end
