require 'rails_helper'

describe HackroomsController do
  describe 'GET show' do
    let(:hackroom) { FactoryGirl.create(:hackroom, name: 'Rails room', id: 5) }
    let(:current_user) { double(:user) }
    subject(:request) { get :show, id: hackroom.id }

    before do
      allow(Hackroom).to receive(:find).and_return(hackroom)
      allow(controller).to receive(:current_user).and_return(current_user)
    end

    it 'assigns a hackroom instance variable' do
      request
      expect(assigns(:hackroom)).to eq hackroom
    end
  end
end
