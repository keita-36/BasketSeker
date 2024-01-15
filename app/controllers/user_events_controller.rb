class UserEventsController < ApplicationController
    before_action :authenticate_user!
    def create
        @event = Event.find(params[:event_id])
        @user_event = UserEvent.create(user: current_user, event: @event)
        redirect_to @event, flash: { success: 'イベントに参加しました。' }
    end

    def destroy
        @event = Event.find(params[:event_id])
        @user_event = UserEvent.find_by(user: current_user, event: @event)
        @user_event.destroy
        redirect_to @event, flash: { danger: 'イベント参加をキャンセルしました。' }
    end
end
