require 'rails_helper'

describe 'users/index.html.haml' do
  before do
    stub_template '_heading.html.haml' => ''
    stub_template '_filter.html.haml' => ''
    stub_template '_results.html.haml' => ''
  end

  it_behaves_like 'searchable list'

  it 'sets page title' do
    expect(view).to receive(:set_page_title).with('Members')
    render
  end

  it 'renders resource introduction' do
    render
    expect(rendered).to have_content('Profiles help us find people with shared interests')
  end
end
