class NotificationsController < ApplicationController
    before_action :authenticate_user!
    def index
        @notifications = current_user.passive_notifications.includes(:visitor, :visited, :user_event, :message, notifiable: [:event, { room: :event }])
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
