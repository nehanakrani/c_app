# spec/models/room_spec.rb

require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it 'has many messages' do
      expect(Room.reflect_on_association(:messages).macro).to eq(:has_many)
    end

    it 'has many participants' do
      expect(Room.reflect_on_association(:participants).macro).to eq(:has_many)
      expect(Room.reflect_on_association(:participants).options[:dependent]).to eq(:destroy)
    end
  end

  describe 'validations' do
    it 'validates uniqueness of name' do
      create(:room, name: 'Existing Room')
      room = build(:room, name: 'Existing Room')

      expect(room).not_to be_valid
      expect(room.errors[:name]).to include('has already been taken')
    end
  end

  describe 'scopes' do
    describe '.public_rooms' do
      it 'returns only public rooms' do
        public_room = create(:room, is_private: false)
        private_room = create(:room, is_private: true)

        expect(Room.public_rooms).to include(public_room)
        expect(Room.public_rooms).not_to include(private_room)
      end
    end
  end

  describe 'callbacks' do
    describe 'after_create_commit' do
      it 'broadcasts the room creation if public' do
        room = build(:room, is_private: false)

        expect do
          room.save
        end.to have_broadcasted_to('rooms').from_channel(Turbo::StreamsChannel).with do |payload|
          expect(payload[:action]).to eq(:append)
          expect(payload[:id]).to eq("room_#{room.id}")
        end
      end
    end
  end

  describe '.create_private_room' do
    it 'creates a private room with participants' do
      users = create_list(:user, 3)
      room_name = 'Private Room'

      private_room = Room.create_private_room(users, room_name)

      expect(private_room).to be_persisted
      expect(private_room.is_private).to eq(true)
      expect(private_room.participants.count).to eq(users.count)
    end
  end
end
