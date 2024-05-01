# spec/models/message_spec.rb

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end

  describe "callbacks" do
    it "broadcasts the message creation via Turbo Streams after create" do
      message = build(:message)

      expect {
        message.save
      }.to have_broadcasted_to("rooms").from_channel(Turbo::StreamsChannel).with do |payload|
        expect(payload[:action]).to eq(:append)
        expect(payload[:id]).to eq("message_#{message.id}")
      end
    end

    it "does not create a message if user is not a participant in a private room" do
      user = create(:user)
      private_room = create(:room, is_private: true)
      message_params = { body: "Test message", room_id: private_room.id }

      expect {
        user.messages.create(message_params)
      }.not_to change(Message, :count)
    end
  end
end
