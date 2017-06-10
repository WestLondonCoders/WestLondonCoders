require 'rails_helper'
include Warden::Test::Helpers

feature 'accessing edit resource pages' do

  context 'as a logged out user' do

    scenario 'trying to edit a users profile' do
      when_there_are_users
      visit edit_user_path(@christina)
      then_i_should_be_redirected_to_people_page
    end

    scenario 'trying to edit a language' do
      when_there_are_languages
      visit edit_language_path(@ruby)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

    scenario 'trying to edit a hackroom' do
      when_there_are_hackrooms
      visit edit_hackroom_path(@ruby_room)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

    scenario 'trying to edit a post' do
      when_there_are_posts
      visit edit_post_path(@ruby_post)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

    scenario 'trying to edit an meetup' do
      when_there_are_meetups
      visit edit_admin_meetup_path(@ruby_meetup)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

    scenario 'trying to edit a sponsor' do
      when_there_are_sponsors
      visit edit_admin_sponsor_path(@sponsor)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end
  end

  as_a_logged_in_user do

    scenario 'trying to edit a users profile' do
      when_there_are_users
      visit edit_user_path(@christina)
      then_i_should_be_redirected_to_people_page
    end

    scenario 'trying to edit a language' do
      when_there_are_languages
      visit edit_language_path(@ruby)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

    scenario 'trying to edit a hackroom' do
      when_there_are_hackrooms
      visit edit_hackroom_path(@ruby_room)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

    scenario 'trying to edit a post' do
      when_there_are_posts
      visit edit_post_path(@ruby_post)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

    scenario 'trying to edit an meetup' do
      when_there_are_meetups
      visit edit_admin_meetup_path(@ruby_meetup)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

    scenario 'trying to edit a sponsor' do
      when_there_are_sponsors
      visit edit_admin_sponsor_path(@sponsor)
      then_i_should_be_redirected_to_people_page
      and_notified_of_authorisation_failure
    end

  end

  as_an_admin do

    scenario 'trying to edit a users profile' do
      when_there_are_users
      visit edit_user_path(@christina)
      then_i_should_not_be_redirected_to_people_page
    end

    scenario 'trying to edit a language' do
      when_there_are_languages
      visit edit_language_path(@ruby)
      then_i_should_not_be_redirected_to_people_page
    end

    scenario 'trying to edit a hackroom' do
      when_there_are_hackrooms
      visit edit_hackroom_path(@ruby_room)
      then_i_should_not_be_redirected_to_people_page
    end

    scenario 'trying to edit a post' do
      when_there_are_posts
      visit edit_post_path(@ruby_post)
      then_i_should_not_be_redirected_to_people_page
    end

    scenario 'trying to edit an meetup' do
      when_there_are_meetups
      visit edit_admin_meetup_path(@ruby_meetup)
      then_i_should_not_be_redirected_to_people_page
    end

    scenario 'trying to edit a sponsor' do
      when_there_are_sponsors
      visit edit_admin_sponsor_path(@sponsor)
      then_i_should_not_be_redirected_to_people_page
    end

  end

  private

  def then_i_should_not_be_redirected_to_people_page
    expect(current_path).to_not eq(users_path)
  end

  def and_notified_of_authorisation_failure
    expect(page).to have_content('You are not authorized to access this page.')
  end
end
