require 'rails_helper'

describe 'pages/home.html.haml' do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { [post] }
  let(:sponsor) { FactoryGirl.create(:sponsor) }
  let(:sponsors) { [sponsor] }
  let(:next_meetup) { FactoryGirl.create(:meetup, date: 1.week.from_now, finish_date: 1.week.from_now) }

  before do
    allow(posts).to receive(:take).and_return(posts)
    allow(view).to receive(:can?).and_return(false)

    assign(:posts, posts)
    assign(:sponsors, sponsors)
    assign(:next_meetup, next_meetup)
    stub_template 'shared/_posts.html.haml' => ''
    stub_template 'pages/_comments_feed.html.haml' => ''
  end

  it 'sets page title' do
    expect(view).to receive(:set_page_title).with('Learn, discuss and practice code')
    render
  end

  it 'displays sponsor logos' do
    render
    expect(rendered).to have_css("img[src*='example-sponsor-logo.jpg']")
  end

  it 'displays featured posts' do
    render
    expect(rendered).to render_template(partial: 'shared/_posts', locals: { posts: posts })
  end

  it 'displays latest comments' do
    render
    expect(rendered).to render_template(partial: '_comments_feed')
  end

  it 'displays the rsvp button for the next event' do
    render
    expect(rendered).to have_link('RSVP', href: new_user_session_path)
  end

  context 'when signed in' do
    let(:current_user) { FactoryGirl.create(:user) }

    before do
      allow(view).to receive(:current_user).and_return(current_user)
    end

    it 'displays the rsvp button for the next meetup' do
      render
      expect(rendered).to have_link('RSVP', href: rsvp_meetup_path(next_meetup))
    end

    it 'displays the cancel rsvp button if I am attending' do
      allow(view).to receive(:user_attending_meetup?).and_return(true)
      render
      expect(rendered).to have_link('Cancel your RSVP', href: rsvp_meetup_path(next_meetup))
    end
  end
end
