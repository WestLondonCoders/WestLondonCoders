require 'rails_helper'
include Warden::Test::Helpers

feature 'searching for things' do

  as_a_logged_in_user do

    scenario 'finding people' do
      when_there_are_users
      visit users_path
      then_i_should_see_my_name
      then_i_should_see_christina
      when_i_search_tom
      then_i_should_see_tom
      but_not_christina
      when_i_click_on_tom
      then_i_am_taken_to_his_profile
    end

  end

  private

  def then_i_should_see_my_name
    expect(page).to have_content('My name')
  end

  def then_i_should_see_christina
    expect(page).to have_content('Christina')
  end

  def when_i_search_tom
    fill_in 'search', with: 'tom'
    click_on 'Search'
  end

  def then_i_should_see_tom
    expect(page).to have_content('Tom')
  end

  def but_not_christina
    expect(page).to_not have_content('Christina')
  end

  def when_i_click_on_tom
    click_on 'Tom'
  end

  def then_i_am_taken_to_his_profile
    expect(current_path).to eq(user_path(@tom))
  end
end
