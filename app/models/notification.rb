class Notification < ApplicationRecord
    default_scope -> { order(created_at: :desc) }
    belongs_to :user_event, optional: true
    belongs_to :message, optional: true

    belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
    belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
    belongs_to :notifiable, polymorphic: true

    enum action: { user_event: 10, message: 20 }
end