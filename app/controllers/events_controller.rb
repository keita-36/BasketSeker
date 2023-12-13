class EventsController < ApplicationController

    def index
        @events = Event.all.includes(:user).order(created_at: :desc).page(params[:page])
    end

    def show
        @event = Event.find(params[:id])
    end
end