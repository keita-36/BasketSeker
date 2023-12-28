class NotificationsController < ApplicationController
    def index
        @notifications = current_user.passive_notifications
        @notifications.each do |notification|
            notification.update(checked: true)
        end
    end

    def destroy
        @notification = Notification.find(params[:id])
        @notification.destroy
        redirect_to notifications_path
    end
end
