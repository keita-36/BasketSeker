class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :user_events_boards, through: :user_events, source: :board
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
