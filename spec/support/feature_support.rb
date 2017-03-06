module FeatureSupport
  module ClassMethods
    def as_a_logged_in_user(&block)
      context 'as a logged in user' do
        let(:user) { FactoryGirl.create(:user, email: 'user@example.com', name: 'My name') }

        before do
          login_as user
        end

        instance_eval(&block)
      end
    end

    def as_an_admin(&block)
      context 'as an admin' do
        let(:admin) { FactoryGirl.create(:admin, email: 'admin@example.com', name: 'Steve') }

        before do
          login_as admin
        end

        instance_eval(&block)
      end
    end
  end

  RSpec.configure do |config|
    config.include self, type: :feature
    config.extend ClassMethods, type: :feature
  end
end
