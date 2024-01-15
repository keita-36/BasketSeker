class EventAttendancesController < ApplicationController
    before_action :authenticate_user!

    def create
        @event = Event.find(params[:event_id])
        current_user.bookmark(@event)
        respond_to do |format|
            format.html { redirect_to events_path, notice: 'イベントを検討中に登録しました。' }
            format.js 
        end
    end
    
    def destroy
        @event = current_user.event_attendances.find(params[:id]).event
        current_user.unbookmark(@event)
        respond_to do |format|
            format.html { redirect_to events_path, alert: 'イベントを検討中から削除しました。' }
            format.js 
        end
    end
end
