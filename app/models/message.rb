class Message < ApplicationRecord
  after_create_commit :create_notification
  after_create_commit { MessageBroadcastJob.perform_later self, self.user_id }
  
  belongs_to :user
  belongs_to :room

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true

  private
  def create_notification
    participants = self.room.event.user_events.map(&:user)

    participants.each do |participant|
      next if self.user_id == participant.id

      Notification.create(
        visitor_id: self.user_id,
        visited_id: participant.id,
        notifiable: self,
        action: 20
      )
    end
  end

end
