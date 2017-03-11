require 'rails_helper'
include Warden::Test::Helpers

feature 'administering events' do

  as_an_admin do

    scenario 'scheduling new events' do
      visit admin_events_path
      then_i_should_see_the_admin_navbar
      given_there_is_a_sponsor
      when_i_schedule_a_meetup
      then_i_should_see_the_meetup
    end

    scenario 'editing existing events' do
      given_there_is_a_sponsor
      given_there_is_a_meetup
      and_i_edit_the_meetup
      then_i_should_see_my_changes
    end

  end

  private

  def then_i_should_see_the_admin_navbar
    expect(page).to have_css('.m-admin_bar')
  end

  def given_there_is_a_sponsor
    @sponsor = FactoryGirl.create(:sponsor, id: 1, name: 'Sky')
  end

  def when_i_schedule_a_meetup
    visit new_admin_event_path
    fill_in 'event_name', with: 'Learn, discuss and practice code'
    fill_in 'event_description', with: 'This meetup will be cool'
    fill_in 'event_date', with: '2017-03-17 00:00:00.000000'
    select 'Sky', from: 'event_sponsor_id'
    click_on 'Schedule'
  end

  def then_i_should_see_the_meetup
    expect(page).to have_content('Learn, discuss and practice code')
  end

  def given_there_is_a_meetup
    @meetup = FactoryGirl.create(:event, id: 2, name: 'Learn, do and chat code')
  end

  def and_i_edit_the_meetup
    visit edit_admin_event_path(@meetup)
    fill_in 'event_name', with: 'Rad new name'
    click_on 'Save changes'
  end

  def then_i_should_see_my_changes
    expect(page).to have_content('Rad new name')
    expect(page).to_not have_content('Learn, discuss and practice code')
  end
end
