class Event < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :datetime, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validate :check_location

  belongs_to :user

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  has_many :match_results, dependent: :destroy

  has_many :event_attendances, dependent: :destroy
  has_many :event_attendances_users, through: :event_attendances, source: :user

  has_one :room, dependent: :destroy


  scope :past, -> { where('datetime < ?', Date.today) }

  private
  # この関数は、緯度と経度の値が空白かどうかを確認し、空白である場合はエラーメッセージを追加します。
  def check_location
    if latitude.blank? && longitude.blank?
      errors.add(:base, '住所を入力してください')
      errors.delete(:latitude)
      errors.delete(:longitude)
    end
  end
end
