require 'rails_helper'

describe 'events/index.html.haml' do
  before do
    stub_template '_heading.html.haml' => ''
    stub_template '_filter.html.haml' => ''
    stub_template '_results.html.haml' => ''
    stub_template '_sort.html.haml' => ''
  end

  it_behaves_like 'searchable list'

  it 'sets page title' do
    expect(view).to receive(:set_page_title).with('Meetups')
    render
  end
end
