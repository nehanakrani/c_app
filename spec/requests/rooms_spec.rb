# spec/requests/rooms_spec.rb

require 'rails_helper'

RSpec.describe RoomsController, type: :request do
  describe 'POST /rooms' do
    context 'when user is signed in' do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      context 'with valid parameters' do
        it 'creates a new room' do
          room_params = { room: { name: 'Test Room' } }

          expect do
            post rooms_path, params: room_params
          end.to change(Room, :count).by(1)

          expect(response).to redirect_to(rooms_path)
          expect(flash[:notice]).to eq('Room created successfully.')
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign-in page' do
        room_params = { room: { name: 'Test Room' } }

        post rooms_path, params: room_params

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
