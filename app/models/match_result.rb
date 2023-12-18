class MatchResult < ApplicationRecord
  belongs_to :event
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'
  belongs_to :winner, class_name: 'User'

  def self.result_exists?(user1, user2, event)
    where(event_id: event.id, user_1_id: [user1.id, user2.id], user_2_id: [user1.id, user2.id]).or(
      where(event_id: event.id, user_1_id: [user1.id, user2.id], user_2_id: [user2.id, user1.id])
    ).exists?
  end
end
