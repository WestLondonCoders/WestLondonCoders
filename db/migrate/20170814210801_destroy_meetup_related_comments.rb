class DestroyMeetupRelatedComments < ActiveRecord::Migration[5.1]
  def change
    Comment.where(commentable_type: "Meetup").destroy_all
  end
end
