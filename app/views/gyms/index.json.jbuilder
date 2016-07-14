json.array!(@gyms) do |gym|
  json.extract! gym, :id, :name, :latitude, :longitude, :user_id
  json.url gym_url(gym, format: :json)
end
