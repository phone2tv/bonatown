json.array!(@parks) do |park|
  json.extract! park, :name, :website, :aboutme, :user_id
  json.url park_url(park, format: :json)
end
