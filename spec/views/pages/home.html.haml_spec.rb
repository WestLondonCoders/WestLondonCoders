require 'rails_helper'

describe 'pages/home.html.haml' do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { [post] }

  before do
    allow(posts).to receive(:take).and_return(posts)
    allow(view).to receive(:can?).and_return(false)

    assign(:posts, posts)
    stub_template 'shared/_posts.html.haml' => ''
    stub_template 'pages/_comments_feed.html.haml' => ''
  end

  it 'sets page title' do
    expect(view).to receive(:set_page_title).with('Learn, discuss and practice code')
    render
  end

  it 'displays featured posts' do
    render
    expect(rendered).to render_template(partial: 'shared/_posts', locals: {post: post})
  end

  it 'displays latest comments' do
    render
    expect(rendered).to render_template(partial: '_comments_feed')
  end
end
