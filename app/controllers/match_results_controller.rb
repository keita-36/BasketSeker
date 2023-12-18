class MatchResultsController < ApplicationController
    def new
        @match_result = MatchResult.new
        @event = Event.find(params[:event_id])
        @users = @event.users.where.not(id: current_user.id)
    end

    def create
        @event = Event.find(params[:event_id])
        match_result_params[:results].each do |user_id, result|
            @match_result = MatchResult.new
            @match_result.event = @event
            @match_result.user_1 = current_user
            @match_result.user_2_id = user_id
            @match_result.winner_id = result == 'WIN' ? current_user.id : user_id
            if @match_result.save
                @result_saved = true
            else
                render :new and return
            end
        end
        redirect_to event_path(@event)
    end

    private
    def match_result_params
        params.require(:match_result).permit(results: {})
    end
end
