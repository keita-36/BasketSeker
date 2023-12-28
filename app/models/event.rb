class Event < ApplicationRecord
  belongs_to :user

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  has_many :match_results, dependent: :destroy

  has_many :event_attendances, dependent: :destroy
  has_many :event_attendances_users, through: :event_attendances, source: :user

  has_one :room, dependent: :destroy

  
end
