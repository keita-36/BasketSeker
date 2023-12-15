class Event < ApplicationRecord
  belongs_to :user

  has_many :user_events, dependent: :destroy
  has_many :user_events_users, through: :user_events, source: :user
end
