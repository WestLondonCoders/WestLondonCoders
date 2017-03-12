require 'rails_helper'
include Warden::Test::Helpers

feature 'administering events' do

  as_an_admin do

    scenario 'adding new sponsors' do
      when_there_are_users
      visit admin_sponsors_path
      then_i_should_see_the_admin_navbar
      when_i_create_a_sponsor
      then_i_should_see_the_sponsor_in_admin
      then_i_should_not_see_the_sponsor_on_public_pages
      when_i_make_a_sponsor_listed
      then_i_should_see_the_sponsor_on_public_pages
    end

  end

  as_a_sponsor do

    scenario 'adding new sponsors' do
      visit root_path
      first(:link, "Admin").click
      then_i_should_see_the_admin_navbar
      when_i_edit_my_page
      then_i_should_see_the_changes
    end

  end

  private

  def when_i_create_a_sponsor
    visit new_admin_sponsor_path
    fill_in 'sponsor_name', with: 'Sky'
    fill_in 'sponsor_link', with: 'sky.com'
    fill_in 'sponsor_description_heading', with: 'This sponsor is cool'
    select 'Christina', from: 'sponsor_user_ids'
    click_on 'Add'
  end

  def then_i_should_see_the_sponsor_in_admin
    expect(page).to have_content('Sky')
  end

  def then_i_should_not_see_the_sponsor_on_public_pages
    visit sponsors_path
    expect(page).to_not have_content('Sky')
  end

  def when_i_make_a_sponsor_listed
    visit admin_sponsors_path
    click_on 'Edit'
    find(:css, "#sponsor_listed[value='1']").set(true)
    click_on 'Save changes'
  end

  def then_i_should_see_the_sponsor_on_public_pages
    visit sponsors_path
    expect(page).to have_content('Christina')
  end

  def when_i_edit_my_page
    fill_in 'sponsor_name', with: 'New name'
    find(:css, "#sponsor_listed[value='1']").set(true)
    click_on 'Save changes'
  end

  def then_i_should_see_the_changes
    visit sponsors_path
    expect(page).to have_css("img[src*='example-sponsor-logo.jpg']")
  end
end
