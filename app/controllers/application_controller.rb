class ApplicationController < ActionController::Base
    before_action :set_check_notifications

    private

    def set_check_notifications
        @check_notifications = Notification.where(visited_id: current_user&.id, checked: false) if user_signed_in?
    end
end
