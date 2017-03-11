require 'rails_helper'
include Warden::Test::Helpers

feature 'searching for things' do

  as_a_logged_in_user do

    scenario 'finding posts' do
      when_there_are_posts
      visit posts_path
      then_i_should_see_the_posts
    end

  end

  private

  def then_i_should_see_the_posts
    expect(page).to have_content('Ruby post')
    expect(page).to have_content('Python post')
  end
end
