require 'rails_helper'
include Warden::Test::Helpers

feature 'editing profile' do

  before do
    given_i_have_an_account
    and_there_are_other_users
    login_as(@beyonce, scope: :user)
    visit users_path
  end

  scenario 'finding people' do
    i_should_see_my_name
    i_should_see_christina
    when_i_click_on_christina
    i_am_taken_to_her_profile
  end

  private

  def given_i_have_an_account
    @beyonce = FactoryGirl.create(:user, name: 'Beyonce')
  end

  def and_there_are_other_users
    @christina = FactoryGirl.create(:user, name: 'Christina', email: 'dirrty@aguilera.com')
  end

  def i_should_see_my_name
    expect(page).to have_content('Beyonce')
  end

  def i_should_see_christina
    expect(page).to have_content('Christina')
  end

  def when_i_click_on_christina
    click_on 'Christina'
  end

  def i_am_taken_to_her_profile
    expect(current_path).to eq(user_path(@christina))
  end
end
