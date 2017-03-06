require 'rails_helper'
include Warden::Test::Helpers

feature 'searching for things' do

  as_a_logged_in_user do

    scenario 'finding languages' do
      when_there_are_languages
      visit languages_path
      then_i_should_see_the_languages
      when_i_search_for_ruby
      then_i_should_see_ruby
      but_not_python
      when_i_click_on_ruby
      then_i_am_taken_to_the_ruby_page
    end

  end

  private

  def when_there_are_languages
    @ruby = FactoryGirl.create(:language, name: 'Ruby')
    @python = FactoryGirl.create(:language, name: 'Python')
  end

  def then_i_should_see_the_languages
    expect(page).to have_content('Ruby')
    expect(page).to have_content('Python')
  end

  def when_i_search_for_ruby
    fill_in 'search', with: 'ruby'
    click_on 'Search'
  end

  def then_i_should_see_ruby
    expect(page).to have_content('Ruby')
  end

  def but_not_python
    expect(page).to_not have_content('Python')
  end

  def when_i_click_on_ruby
    click_on 'Ruby'
  end

  def then_i_am_taken_to_the_ruby_page
    expect(current_path).to eq(language_path(@ruby))
  end
end
