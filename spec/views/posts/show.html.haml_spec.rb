require 'rails_helper'

describe 'posts/show.html.haml' do
  let(:post) { FactoryGirl.create(:post) }
  let(:user) { FactoryGirl.create(:user, name: 'Jake Shears') }
  let(:post_attachment) { FactoryGirl.create(:post_attachment) }

  before do
    allow(view).to receive(:can?).and_return(false)

    assign(:user, user)
    assign(:post, post)
    assign(:post_attachments, [])

    stub_template 'posts/templates/_gallery.html.haml' => ''
    stub_template 'posts/templates/_post.html.haml' => ''
    stub_template '_comment_feed.html.haml' => ''
    stub_template '_og_header.html.haml' => ''
  end

  it 'sets page title' do
    expect(view).to receive(:set_page_title).with('Why I love Rails')
    render
  end

  it 'uses post template when no post attachments' do
    render
    expect(rendered).to render_template(partial: 'posts/templates/_post')
  end

  it 'uses gallery template if it has post attachments' do
    allow(post).to receive(:post_attachments).and_return([post_attachment])
    render
    expect(rendered).to render_template(partial: 'posts/templates/_gallery')
  end
end
