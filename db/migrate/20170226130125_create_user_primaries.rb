class CreateUserPrimaries < ActiveRecord::Migration
  def change
    create_table :user_primaries do |t|
      t.references :user, null: false
      t.references :language, null: false
      t.timestamps null: false
    end
  end
end
