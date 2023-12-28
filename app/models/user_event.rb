class UserEvent < ApplicationRecord
  after_create_commit :create_notification

  belongs_to :user
  belongs_to :event

  has_many :notifications, as: :notifiable, dependent: :destroy
  
  private

  def create_notification
    if self.event
    Notification.create(
      visited_id: self.event.user_id,
      visitor_id: self.user_id,
      notifiable: self,
      action: 10
    )
    end
  end
end

