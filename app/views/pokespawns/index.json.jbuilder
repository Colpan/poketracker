json.array!(@pokespawns) do |pokespawn|
  json.extract! pokespawn, :id, :name, :latitude, :longitude, :user_id
  json.url pokespawn_url(pokespawn, format: :json)
end
