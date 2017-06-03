class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|
      t.references :follower, references: :user, null: false
      t.references :user, references: :user

      t.timestamps null: false
    end
  end
end
