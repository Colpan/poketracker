json.array!(@pokestops) do |pokestop|
  json.extract! pokestop, :id, :name, :latitude, :longitude, :user_id
  json.url pokestop_url(pokestop, format: :json)
end
