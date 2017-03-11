require 'rails_helper'
include Warden::Test::Helpers

feature 'searching for things' do

  as_a_logged_in_user do

    scenario 'finding hackrooms' do
      when_there_are_hackrooms
      visit hackrooms_path
      then_i_should_see_the_hackrooms
      when_i_search_for_ruby_room
      then_i_should_see_ruby_room
      but_not_python_room
      when_i_click_on_ruby_room
      then_i_am_taken_to_ruby_room_page
    end

  end

  private

  def then_i_should_see_the_hackrooms
    expect(page).to have_content('Ruby room')
    expect(page).to have_content('Python room')
  end

  def when_i_search_for_ruby_room
    fill_in 'search', with: 'ruby room'
    click_on 'Search'
  end

  def then_i_should_see_ruby_room
    expect(page).to have_content('Ruby room')
  end

  def but_not_python_room
    expect(page).to_not have_content('Python room')
  end

  def when_i_click_on_ruby_room
    click_on 'Ruby room'
  end

  def then_i_am_taken_to_ruby_room_page
    expect(current_path).to eq(hackroom_path(@ruby_room))
  end
end
