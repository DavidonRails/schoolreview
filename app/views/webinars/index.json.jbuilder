json.array!(@webinars) do |webinar|
  json.extract! webinar, :id, :name, :filepath, :participates, :user_id
  json.url webinar_url(webinar, format: :json)
end
