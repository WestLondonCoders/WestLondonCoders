require 'rails_helper'
include Warden::Test::Helpers

feature 'posting comments' do

  as_a_logged_in_user do

    before do
      when_there_are_posts
    end

    scenario 'comment on a post' do
      and_i_write_a_comment_on_a_post
      then_i_should_see_my_comment_on_the_post
      then_i_should_see_my_comment_on_the_homepage
      then_the_post_author_should_be_notified
    end

    scenario 'reply to a comment' do
      and_there_is_a_comment
      when_i_reply_to_the_comment
      then_i_should_see_my_reply
      then_the_comment_author_should_be_notified
    end

  end

  private

  def and_i_write_a_comment_on_a_post
    visit post_path(@ruby_post)
    fill_in 'Write a comment...', with: 'Ruby is the bomb'
    click_on 'Post'
  end

  def then_i_should_see_my_comment_on_the_post
    expect(page).to have_content('Ruby is the bomb')
  end

  def then_i_should_see_my_comment_on_the_homepage
    visit root_path
    expect(page).to have_content('Ruby is the bomb')
  end

  def then_the_post_author_should_be_notified
    notification = @author.notifications.last
    expect(notification.notifiable).to eq @ruby_post
    expect(notification.notified_by).to eq user
  end

  def and_there_is_a_comment
    @comment_one = FactoryGirl.create(:comment, commentable: @ruby_post, body: 'I hate Ruby')
  end

  def when_i_reply_to_the_comment
    visit post_path(@ruby_post)
    fill_in 'Reply...', with: 'You deserve to die'
    click_on 'Reply'
  end

  def then_i_should_see_my_reply
    expect(page).to have_content('You deserve to die')
  end

  def then_the_comment_author_should_be_notified
    notification = @comment_one.author.notifications.last
    expect(notification.notifiable).to eq @comment_one
    expect(notification.notified_by).to eq user
  end
end
