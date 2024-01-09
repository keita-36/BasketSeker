class EventsController < ApplicationController
    before_action :authenticate_user!, only: %i[index new create edit update destroy]

    def index
        @events = Event.where('datetime > ?', DateTime.now).includes(:user).order(created_at: :desc).page(params[:page])
        @participating_events = current_user.participating_events.page(params[:page])
        @favorited_events = current_user.favorited_events.page(params[:page])
        @past_events = Event.past.page(params[:page])
    end

    def show
        @event = Event.find(params[:id])
        @messages = Message.where(room_id: @event.room.id)

        # このコードは、Google Maps Geocoding API に対して、指定された緯度と経度の書式設定された住所を取得するリクエストを行っています。
        uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{@event.latitude},#{@event.longitude}&key=#{ENV['API_KEY']}&language=ja")
        response = Net::HTTP.get(uri)
        data = JSON.parse(response)
        @address = data['results'][0]['formatted_address'].sub(/日本、/, '') if data['results'].present?
    end

    def create
        @event = current_user.events.build(event_params)
        if @event.save
            UserEvent.create(user: current_user, event: @event)
            Room.create!(event: @event)
            redirect_to events_path
        else
            render :new
        end
    end

    def new
        @event = Event.new
        @event.latitude = params[:lat]
        @event.longitude = params[:lng]

        uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{@event.latitude},#{@event.longitude}&key=#{ENV['API_KEY']}&language=ja")
        response = Net::HTTP.get(uri)
        data = JSON.parse(response)
        @address = data['results'][0]['formatted_address'].sub(/日本、/, '')  if data['results'].present?

    end

    def update
        @event = current_user.events.find(params[:id])
        if @event.update(event_params)
            redirect_to @event
        else
            render :edit
        end
    end

    def edit
        @event = Event.find(params[:id])
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to events_path
    end

    private

    def event_params
        params.require(:event).permit(:title, :datetime, :latitude, :longitude, :content)
    end
end
