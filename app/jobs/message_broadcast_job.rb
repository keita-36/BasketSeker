class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, user_id)
    user = User.find(user_id)
    ActionCable.server.broadcast 'room_channel', { id: message.id, message: render_message(message, user) }
  end

  private

  def render_message(message, user)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: user })
  end
end
