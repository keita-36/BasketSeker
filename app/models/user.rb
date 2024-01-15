class User < ApplicationRecord
  has_many :events, dependent: :destroy

  #イベント参加機能
  has_many :user_events, dependent: :destroy
  has_many :user_events_boards, through: :user_events, source: :board

  #結果登録機能
  has_many :user_1_match_results, class_name: 'MatchResult', foreign_key: 'user_1_id'
  has_many :user_2_match_results, class_name: 'MatchResult', foreign_key: 'user_2_id'
  has_many :won_match_results, class_name: 'MatchResult', foreign_key: 'winner_id'
  
  #お気に入り機能
  has_many :event_attendances, dependent: :destroy
  has_many :event_attendances_events, through: :event_attendances, source: :event

  #チャット機能
  has_many :messages, dependent: :destroy
  has_many :message_rooms, through: :messages, source: :room

  #通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  #画像アップロード機能
  mount_uploader :play_video, VideoUploader
  mount_uploader :avatar,AvatarUploader

  #gem devise
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :recoverable
  

  def participating_in?(event)
    self.user_events.exists?(event_id: event.id)
  end

  def bookmark(event)
    event_attendances_events << event
  end

  def unbookmark(event)
    event_attendances_events.destroy(event)
  end

  # この関数は、イベントがユーザーによってブックマークされているかどうかを確認します。
  def bookmark?(event)
    event_attendances_events.include?(event)
  end

  # ユーザーが参加しているイベントを返します。
  def participating_events
    Event.joins(:user_events).where(user_events: { user_id: id })
  end

  # ユーザーがお気に入りに登録したイベントを返します。
  def favorited_events
    event_attendances_events
  end


  # テーブルにイベントが存在しないかどうかを確認することで、イベントのブックマークが解除されているかどうかを確認します。
  def unbookmarked?(event)
    !event_attendances_events.exists?(event_id: event.id)
  end
end
