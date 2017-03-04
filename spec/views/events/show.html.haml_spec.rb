require 'rails_helper'

describe 'events/show.html.haml' do
  let(:event) { FactoryGirl.create(:event) }

  let(:attending_user) { FactoryGirl.create(:user, name: 'Beth') }
  let(:attending_organiser) { FactoryGirl.create(:user, name: 'Jerome') }
  let(:event_rsvp) { double(:event_rsvp) }

  let(:primary_language) { FactoryGirl.create(:language) }

  let(:current_user) { FactoryGirl.create(:user) }

  before do
    allow(view).to receive(:can?).and_return(false)
    allow(view).to receive(:current_user).and_return(current_user)

    allow(event).to receive(:rsvps).and_return([attending_user, attending_organiser])
    allow(attending_user).to receive(:primary_languages).and_return([primary_language])
    allow(event).to receive(:languages).and_return([primary_language])

    assign(:event, event)
  end

  it 'sets page title' do
    expect(view).to receive(:set_page_title).with('Learn, discuss and practice code')
    render
  end

  it 'displays edit event button if user can edit' do
    allow(view).to receive(:can?).with(:manage, event).and_return(true)
    render
    expect(rendered).to have_link('Edit event', edit_event_path(event))
  end

  it 'displays an organiser list' do
    render

    expect(rendered).to have_content('Jerome')
  end

  it 'displays event description' do
    render
    expect(rendered).to have_content('This meetup will be cool')
  end

  it 'displays guest list' do
    render
    expect(rendered).to have_content('Beth')
  end

  it 'displays a list of primary languages of guests' do
    render
    expect(rendered).to have_content('Ruby')
  end
end
