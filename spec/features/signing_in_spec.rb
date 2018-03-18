require 'rails_helper'

feature 'user sign-in' do

  scenario 'user can sign in and out' do
    as_beyonce
    visit new_user_registration_path
    create_an_account
    visit user_path(@beyonce)
    i_should_see_my_name
  end

  private

  def as_beyonce
    @beyonce = FactoryBot.create(:user, name: 'Beyonce', email: 'beyonce@star.com', password: 'wtf123')
  end

  def create_an_account
    fill_in 'Name', with: 'Beyonce'
    fill_in 'Email', with: 'beyonce@star.com'
    fill_in 'Password', with: 'wtf123'
    click_on 'Sign up'
  end

  def i_should_see_my_name
    expect(page).to have_content("Beyonce")
  end
end
