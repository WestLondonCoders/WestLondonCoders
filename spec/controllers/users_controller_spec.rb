# require 'rails_helper'

# describe UsersController do
#   describe 'GET show' do
#     let(:user) { FactoryGirl.create(:user, name: 'Hilary Clinton', id: 2) }
#     let(:current_user) { double(:user) }

#     before do
#       allow(controller).to receive(:current_user).and_return(current_user)
#       allow(User).to receive(:find).and_return(user)
#     end

#     it 'assigns a user instance variable' do
#       get :show, params: { id: '2' }
#       expect(assigns(:user)).to eq user
#     end
#   end
# end

