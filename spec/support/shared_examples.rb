shared_examples_for 'searchable list' do
  before do
    stub_template '_heading.html.haml' => ''
    stub_template '_filter.html.haml' => ''
    stub_template '_results.html.haml' => ''
  end

  it 'renders the list heading' do
    render
    expect(rendered).to render_template('_heading')
  end

  it 'renders the resource filter' do
    render
    expect(rendered).to render_template('_filter')
  end

  it 'renders the resource search results' do
    render
    expect(rendered).to render_template('_results')
  end
end
