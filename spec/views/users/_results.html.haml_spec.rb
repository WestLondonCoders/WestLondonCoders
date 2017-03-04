require 'rails_helper'

describe 'users/_results.html.haml' do
  let(:user) { FactoryGirl.create(:user, name: 'Jake Shears') }
  let(:users) { [user] }

  let(:language) { FactoryGirl.create(:language) }
  let(:languages) { [language] }

  let(:current_user) { double { :user } }

  before do
    allow(user).to receive(:primary_languages).and_return(languages)

    assign(:users, users)
    assign(:languages, languages)
  end

  it 'displays a link to each user' do
    render
    expect(rendered).to have_link('Jake Shears', user_path(user))
  end

  it 'displays social links for each user' do
    render
    expect(rendered).to render_template(partial: 'users/_social_links', locals: { user: user })
  end

  it 'displays a link to each user\'slanguage' do
    render
    expect(rendered).to have_link('Ruby', language_path(language))
    expect(rendered).to have_css('h2', 'a-paint-background--26')
  end

  it 'adds an underline with the language colour' do
    render
    expect(rendered).to have_css('h2', 'a-paint-border-bottom--26')
  end
end
