class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :user_events_boards, through: :user_events, source: :board
  has_many :user_1_match_results, class_name: 'MatchResult', foreign_key: 'user_1_id'
  has_many :user_2_match_results, class_name: 'MatchResult', foreign_key: 'user_2_id'
  has_many :won_match_results, class_name: 'MatchResult', foreign_key: 'winner_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :play_video, VideoUploader
  mount_uploader :avatar,AvatarUploader

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  

  def participating_in?(event)
    self.user_events.exists?(event_id: event.id)
  end
end
