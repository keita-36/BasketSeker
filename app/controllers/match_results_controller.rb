class MatchResultsController < ApplicationController
    before_action :authenticate_user!, only: %i[new create index]

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
                redirect_to event_path(@event), flash: { success: '対戦結果を登録しました' }
            else
                render :new and return
            end
        end
    end

    def index
        @match_counts = MatchResult.match_count.sort_by { |_, v| -v }
        @win_counts = MatchResult.win_count.sort_by { |_, v| -v }
        @win_rates = MatchResult.win_rate.sort_by { |_, v| -v }
    end

    private
    def match_result_params
        params.require(:match_result).permit(results: {})
    end
end
