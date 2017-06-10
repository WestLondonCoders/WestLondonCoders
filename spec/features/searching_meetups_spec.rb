require 'rails_helper'
include Warden::Test::Helpers

feature 'searching for things' do

  as_a_logged_in_user do

    scenario 'finding meetups' do
      when_there_are_meetups
      visit meetups_path
      then_i_should_see_the_meetups
      when_i_search_for_ruby_meetup
      then_i_should_see_ruby_meetup
      but_not_python_meetup
      when_i_click_on_ruby_meetup
      then_i_am_taken_to_ruby_meetup_page
    end

  end

  private

  def then_i_should_see_the_meetups
    expect(page).to have_content('Ruby meetup')
    expect(page).to have_content('Python meetup')
  end

  def when_i_search_for_ruby_meetup
    fill_in 'search', with: 'ruby meetup'
    click_on 'Search'
  end

  def then_i_should_see_ruby_meetup
    expect(page).to have_content('Ruby meetup')
  end

  def but_not_python_meetup
    expect(page).to_not have_content('Python meetup')
  end

  def when_i_click_on_ruby_meetup
    click_on 'Ruby meetup'
  end

  def then_i_am_taken_to_ruby_meetup_page
    expect(current_path).to eq(meetup_path(@ruby_meetup))
  end
end
