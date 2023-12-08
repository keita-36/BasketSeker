require 'csv'
require 'open-uri'
API_KEY = ENV['API_KEY']

namespace :fetch_parks do
  desc 'Fetch and save park details'
  task :get_and_save_details => :environment do
    def get_place_id(address)
      client = GooglePlaces::Client.new(API_KEY)
      spot = client.spots_by_query(address).first
      spot.place_id if spot
    end

    def get_detail_data(park)
      place_id = get_place_id(park['住所'])

      if place_id
        existing_park = Park.find_by(place_id: place_id) # データベース内を検索
        if existing_park
          puts "既に保存済みです: #{park['公園名']}"
          return nil
        end

        place_detail_query = URI.encode_www_form(
          place_id: place_id,
          language: 'ja',
          key: API_KEY
        )
        place_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?#{place_detail_query}"
        place_detail_page = URI.open(place_detail_url).read
        place_detail_data = JSON.parse(place_detail_page)

        result = {}
        result[:name] = park['公園名']
        result[:postal_code] = place_detail_data['result']['address_components'].find { |c| c['types'].include?('postal_code') }&.fetch('long_name', nil)

        full_address = place_detail_data['result']['formatted_address']
        result[:address] = full_address.sub(/\A[^ ]+/, '')

        result[:opening_hours] = place_detail_data['result']['opening_hours']['weekday_text'].join("\n") if place_detail_data['result']['opening_hours'].present?
        result[:latitude] = place_detail_data['result']['geometry']['location']['lat']
        result[:longitude] = place_detail_data['result']['geometry']['location']['lng']
        result[:place_id] = place_id
        result[:web_site] = place_detail_data['result']['website']

        result
      else
        puts "詳細情報が見つかりませんでした。"
        nil
      end
    end

    csv_file = 'lib/tasks/parks.csv'
    CSV.foreach(csv_file, headers: true) do |row|
      park_data = get_detail_data(row)
      if park_data
        park= Park.create!(park_data)
        puts "Parkを保存しました: #{row['公園名']}"
        puts "----------"
      else
        puts "Parkの保存に失敗しました: #{row['公園名']}"
      end
    end
  end
end
