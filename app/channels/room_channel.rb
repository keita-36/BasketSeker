class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    event = Event.find_by(id: data['event_id'])
    if event
      Message.create! content: data['message'], user_id: current_user.id, room_id: event.room.id
    end
  end
end
