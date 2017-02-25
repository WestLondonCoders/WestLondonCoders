class CreateUserHackrooms < ActiveRecord::Migration
  def change
    create_table :user_hackrooms do |t|
      t.references :user, null: false
      t.references :hackroom, null: false
      t.timestamps null: false
    end
  end
end
