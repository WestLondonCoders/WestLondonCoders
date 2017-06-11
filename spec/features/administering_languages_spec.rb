require 'rails_helper'
include Warden::Test::Helpers

feature 'administering languages' do

  as_an_admin do

    scenario 'scheduling new languages' do
      when_i_create_a_new_language
      then_i_should_see_the_language
      and_i_should_be_the_language_author
    end

    scenario 'editing existing languages' do
      when_there_are_languages
      and_i_edit_the_language
      then_i_should_see_my_changes
    end

  end

  private

  def when_i_create_a_new_language
    visit languages_path
    click_on 'Add language'
    fill_in 'language_name', with: 'SteveScript'
    fill_in 'language_description', with: 'This language is cool'
    click_on 'Save'
  end

  def then_i_should_see_the_language
    expect(page).to have_content('SteveScript')
  end

  def and_i_should_be_the_language_author
    expect(Language.last.author).to eq admin
  end

  def and_i_edit_the_language
    visit edit_language_path(@ruby)
    fill_in 'language_name', with: 'Rubee'
    click_on 'Save'
  end

  def then_i_should_see_my_changes
    expect(page).to have_content('Rubee')
    expect(page).to_not have_content('Ruby')
  end
end
