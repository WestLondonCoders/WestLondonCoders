# require 'rails_helper'

# describe LanguagesController do
#   describe 'GET show' do
#     let(:language) { FactoryGirl.create(:language, name: 'Ruby', id: 10) }
#     let(:current_user) { double(:user) }
#     subject(:request) { get :show, id: language.id }

#     before do
#       allow(Language).to receive(:find).and_return(language)
#       allow(controller).to receive(:current_user).and_return(current_user)
#     end

#     it 'assigns a language instance variable' do
#       request
#       expect(assigns(:language)).to eq language
#     end
#   end
# end
