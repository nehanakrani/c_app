class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
  end

  def show
    @single_room = Room.find(params[:id])

    @room = Room.new
    @rooms = Room.public_rooms

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users = User.all_except(current_user)

    render 'index'
  end

  def create
    @room = Room.new(name: params['room']['name'])

    if @room.save
      flash[:notice] = 'Room created successfully.'
      redirect_to action: 'index'
    else
      flash.now[:alert] = @room.errors.full_messages.to_sentence
      render partial: 'rooms/new_room_form', locals: { room: @room }
    end
  end
end
