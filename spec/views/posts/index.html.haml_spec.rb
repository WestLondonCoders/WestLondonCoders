require 'rails_helper'

describe 'posts/index.html.haml' do
  before do
    stub_template '_heading.html.haml' => ''
    stub_template '_filter.html.haml' => ''
    stub_template '_results.html.haml' => ''
  end
end
