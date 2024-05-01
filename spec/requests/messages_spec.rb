RSpec.describe MessagesController, type: :request do
  describe 'POST /rooms/:room_id/messages' do
    let!(:user) { create(:user) }
    let!(:room) { create(:room) }

    context 'when user is signed in and provides valid parameters' do
      it 'creates a new message' do
        sign_in user
        valid_message_params = { message: { body: 'Test message' } }

        expect do
          post "/rooms/#{room.id}/messages", params: valid_message_params
        end.to change(Message, :count).by(1)

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
