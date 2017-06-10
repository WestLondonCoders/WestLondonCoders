require 'rails_helper'
include Warden::Test::Helpers

feature 'administering meetups' do

  as_an_admin do

    scenario 'scheduling new meetups' do
      visit admin_meetups_path
      then_i_should_see_the_admin_navbar
      given_there_is_a_sponsor
      when_i_schedule_a_meetup
      then_i_should_see_the_meetup
    end

    scenario 'editing existing meetups' do
      given_there_is_a_sponsor
      given_there_is_a_meetup
      and_i_edit_the_meetup
      then_i_should_see_my_changes
    end

  end

  private

  def given_there_is_a_sponsor
    @sponsor = FactoryGirl.create(:sponsor, id: 1, name: 'Sky')
  end

  def when_i_schedule_a_meetup
    visit new_admin_meetup_path
    fill_in 'meetup_name', with: 'Learn, discuss and practice code'
    fill_in 'meetup_description', with: 'This meetup will be cool'
    fill_in 'meetup_date', with: '2017-03-17 00:00:00.000000'
    select 'Sky', from: 'meetup_sponsor_id'
    click_on 'Schedule'
  end

  def then_i_should_see_the_meetup
    expect(page).to have_content('Learn, discuss and practice code')
  end

  def given_there_is_a_meetup
    @meetup = FactoryGirl.create(:meetup, id: 2, name: 'Learn, do and chat code')
  end

  def and_i_edit_the_meetup
    visit edit_admin_meetup_path(@meetup)
    fill_in 'meetup_name', with: 'Rad new name'
    click_on 'Save changes'
  end

  def then_i_should_see_my_changes
    expect(page).to have_content('Rad new name')
    expect(page).to_not have_content('Learn, discuss and practice code')
  end
end
