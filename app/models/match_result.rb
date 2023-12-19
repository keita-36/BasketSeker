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

  def self.match_count
    User.all.map do |user|
      [user, where(user_1: user).or(where(user_2: user)).count]
    end.to_h
  end

  def self.win_count
    User.all.map do |user|
      [user, where(winner: user).count]
    end.to_h
  end

  def self.win_rate
    match_counts = self.match_count
    win_counts = self.win_count

    User.all.map do |user|
      match_count = match_counts[user]
      win_count = win_counts[user]

      win_rate = match_count.zero? ? 0 : (win_count.to_f / match_count * 100).round(2)
      [user, win_rate]
    end.to_h
  end
end