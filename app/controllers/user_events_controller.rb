class UserEventsController < ApplicationController
    def create
        @event = Event.find(params[:event_id])
        @user_event = UserEvent.create(user: current_user, event: @event)
        redirect_to @event
    end

    def destroy
        @event = Event.find(params[:event_id])
        @user_event = UserEvent.find_by(user: current_user, event: @event)
        @user_event.destroy
        redirect_to @event
    end
end
