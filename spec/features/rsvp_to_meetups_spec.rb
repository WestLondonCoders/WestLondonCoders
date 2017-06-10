require 'rails_helper'
include Warden::Test::Helpers

feature 'rsvp to meetups' do

  as_a_logged_in_user do

    before do
      when_there_are_languages
      when_there_are_meetups
      visit meetup_path(@ruby_meetup)
    end

    scenario 'rsvp to an meetup' do
      and_i_have_a_primary_language
      and_i_rsvp
      then_my_name_should_appear_on_the_list
      and_my_language_should_be_on_the_page
      and_i_should_be_able_to_unrsvp
    end

    scenario 'cancelling rsvp to an meetup' do
      and_i_rsvp
      and_i_unrsvp
    end

  end

  private

  def and_i_have_a_primary_language
    user.primary_languages = [@ruby]
  end

  def and_i_rsvp
    within ".a-section--separated" do
      first(:link, "RSVP").click
    end
  end

  def then_my_name_should_appear_on_the_list
    expect(page).to have_content('My name')
  end

  def and_my_language_should_be_on_the_page
    expect(page).to have_content('Ruby')
  end

  def and_i_should_be_able_to_unrsvp
    expect(page).to have_content('Cancel your RSVP')
  end

  def and_i_unrsvp
    within ".a-section--separated" do
      first(:link, "Cancel your RSVP").click
    end
  end

  def then_my_name_should_come_off_the_list
    expect(page).to_not have_content('My name')
  end
end
