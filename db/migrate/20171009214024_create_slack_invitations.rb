class CreateSlackInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_invitations do |t|
      t.string :email, null: false
      t.references :user
      t.timestamps null: false
    end
  end
end
