require 'rails_helper'

describe 'sponsors/show.html.haml' do
  let(:sponsor) { FactoryGirl.create(:sponsor) }
  let(:current_user) { FactoryGirl.create(:user) }

  before do
    allow(view).to receive(:can?).and_return(false)
    allow(view).to receive(:current_user).and_return(current_user)

    assign(:sponsor, sponsor)
  end

  it 'sets page title' do
    expect(view).to receive(:set_page_title).with('Net-a-porter')
    render
  end

  it 'displays edit sponsor button if user can edit' do
    allow(view).to receive(:can?).with(:manage, sponsor).and_return(true)
    render
    expect(rendered).to have_link('Edit sponsor')
  end
end
