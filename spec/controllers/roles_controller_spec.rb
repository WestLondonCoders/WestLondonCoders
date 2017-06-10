# require 'rails_helper'

# describe RolesController do
#   describe 'GET new' do
#     let(:role) { FactoryGirl.create(:role) }

#     subject(:request) { get :new }

#     before do
#       allow(Role).to receive(:new).and_return(role)
#     end

#     it 'checks that the user is authorised to create roles' do
#       expect_authorization_of(:new, Role)

#       request
#     end
#   end
# end
