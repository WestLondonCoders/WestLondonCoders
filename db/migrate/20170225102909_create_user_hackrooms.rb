class CreateUserHackrooms < ActiveRecord::Migration[4.2]
  def change
    create_table :user_hackrooms do |t|
      t.references :user, null: false
      t.references :hackroom, null: false
      t.timestamps null: false
    end
  end
end
