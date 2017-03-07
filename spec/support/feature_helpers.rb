module FeatureHelpers
  def when_there_are_users
    @christina = FactoryGirl.create(:user, name: 'Christina', email: 'dirrty@aguilera.com')
    @tom = FactoryGirl.create(:user, name: 'Tom', email: 'tom@person.com')
  end

  def when_there_are_languages
    @ruby = FactoryGirl.create(:language, name: 'Ruby')
    @python = FactoryGirl.create(:language, name: 'Python')
  end

  def when_there_are_hackrooms
    @ruby_room = FactoryGirl.create(:hackroom, name: 'Ruby room')
    @python_room = FactoryGirl.create(:hackroom, name: 'Python room')
  end

  def when_there_are_posts
    @author = FactoryGirl.create(:user, name: 'Author', email: 'dirrty@aguilera.com')
    @ruby_post = FactoryGirl.create(:post, title: 'Ruby post', created_by: @author)
    @python_post = FactoryGirl.create(:post, title: 'Python post', created_by: @author)
  end

  def when_there_are_meetups
    @sponsor = FactoryGirl.create(:sponsor, name: 'Sky')
    @ruby_meetup = FactoryGirl.create(:event, name: 'Ruby meetup', sponsor: @sponsor)
    @python_meetup = FactoryGirl.create(:event, name: 'Python meetup', sponsor: @sponsor)
  end

  def when_there_are_sponsors
    @sponsor = FactoryGirl.create(:sponsor, name: 'Sky')
  end

  def then_i_should_be_redirected_to_people_page
    expect(current_path).to eq(users_path)
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
