require 'rails_helper'

describe 'sponsors/index.html.haml' do
  let(:sponsor) { FactoryGirl.create(:sponsor, name: 'Sky') }
  let(:sponsors) { [sponsor] }

  let(:current_user) { double { :user } }

  before do
    allow(view).to receive(:current_user).and_return(current_user)
    allow(current_user).to receive(:has_role?).and_return(false)

    assign(:sponsors, sponsors)
  end

  it 'displays a link to each sponsor' do
    render
    expect(rendered).to have_link('Sky', sponsor_path(sponsor))
  end
end
