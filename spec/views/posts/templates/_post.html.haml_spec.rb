require 'rails_helper'

describe 'posts/templates/_post.html.haml' do
  let(:post) { FactoryGirl.create(:post, created_by: user) }
  let(:user) { FactoryGirl.create(:user, name: 'Jake') }
  let(:tag) { double(:tag, name: 'Rails tag') }

  before do
    allow(post).to receive(:tags).and_return([tag])
    assign(:post, post)
  end

  it 'displays the post title' do
    render
    expect(rendered).to have_content('Why I love Rails')
  end

  it 'displays a link to the author' do
    render
    expect(rendered).to have_link('Jake', user_path(user))
  end

  it 'displays the post content' do
    render
    expect(rendered).to have_content("I love Rails because it's so cool")
  end

  it 'displays each post tag' do
    render
    expect(rendered).to have_content('Rails tag')
  end
end
