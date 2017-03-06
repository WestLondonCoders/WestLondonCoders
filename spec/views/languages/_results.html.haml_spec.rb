require 'rails_helper'

describe 'languages/_results.html.haml' do
  let(:language) { FactoryGirl.create(:language) }
  let(:languages) { [language] }

  let(:user) { FactoryGirl.create(:user) }
  let(:users) { [user] }

  let(:current_user) { double { :user } }

  before do
    allow(language).to receive(:primary_users).and_return(users)

    assign(:languages, languages)
    assign(:users, users)
  end

  it 'displays a link to each language' do
    render
    expect(rendered).to have_link('Ruby', language_path(language))
  end

  it 'adds an underline with the language colour' do
    render
    expect(rendered).to have_css('h1', 'a-paint-border-bottom--26')
  end

  it 'lists the hackrooms using each language' do
    render
    expect(rendered).to render_template(partial: '_hackrooms', locals: { language: language })
  end

  it 'displays the primary user count' do
    render
    expect(rendered).to have_content('1 person primarily using Ruby')
  end

  it 'lists the users with this language' do
    render
    expect(rendered).to render_template(partial: 'shared/_user_tag', locals: { user: user })
  end

  context 'when there are no users using a language' do
    before do
      allow(language).to receive(:primary_users).and_return([])
    end

    it 'renders no user message when nobody is using this language' do
      render
      expect(rendered).to have_content('Nobody is focusing on Ruby at the moment.')
    end

    it 'suggests adding language to profile if user signed in' do
      allow(view).to receive(:current_user).and_return(current_user)
      render
      expect(rendered).to have_content('Would you like to add Ruby to your profile?')
    end
  end

  it 'displays a view button for each language' do
    render
    expect(rendered).to have_link('View', language_path(language))
  end
end
