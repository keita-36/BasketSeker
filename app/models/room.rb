class Room < ApplicationRecord
  belongs_to :message, optional: true
  belongs_to :event

  has_many :messages, dependent: :destroy
end
