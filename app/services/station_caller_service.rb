class StationCallerService < MasterService
  
  def initialize(zip)
    @zip = zip
    @url = "/api/alt-fuel-stations/v1/nearest.json?location=#{@zip}&api_key=#{ENV['API_SECRET']}&radius=6&limit=10"
  end

  def stations
    body = JSON.parse(raw_response(@url), symbolize_names: true)
    serialize(body)
  end

  def serialize(stns)
    stns[:fuel_stations].map do |attrs|
      Station.new(attrs)
    end
  end
end
