require 'rails_helper'

describe 'users/show.html.haml' do
  let(:user) { FactoryGirl.create(:user, name: 'Jake Shears') }
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { [post] }
  let(:interest) { FactoryGirl.create(:interest) }

  before do
    allow(view).to receive(:can?).and_return(false)

    assign(:user, user)
    assign(:posts, posts)

    stub_template 'shared/_user_strip.html.haml' => ''
    stub_template '_meetups.html.haml' => ''
    stub_template '_language_list.html.haml' => ''
    stub_template '_hackrooms.html.haml' => ''
    stub_template 'shared/_posts.html.haml' => ''
  end

  it 'sets page title' do
    expect(view).to receive(:set_page_title).with('Jake Shears')
    render
  end

  it 'displays edit profile button if user can edit' do
    allow(view).to receive(:can?).with(:manage, user).and_return(true)
    render
    expect(rendered).to have_link('Edit profile', href: edit_user_path(user))
  end

  it 'displays user bio' do
    render
    expect(rendered).to have_content('I make cool songs')
  end

  it 'displays user interests if added' do
    allow(user).to receive(:interests).and_return([interest])
    render
    expect(rendered).to have_content('Singing')
  end

  it 'displays add interests button if none added' do
    allow(view).to receive(:can?).with(:edit, user).and_return(true)
    render
    expect(rendered).to have_link('Add some interests', href: edit_interests_path(user))
  end

  it 'displays a list of posts by the user' do
    render
    expect(rendered).to render_template(partial: 'shared/_posts', locals: { post: post })
  end
end
