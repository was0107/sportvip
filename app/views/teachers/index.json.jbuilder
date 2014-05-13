json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :name, :profile_image_url, :description
  json.url teacher_url(teacher, format: :json)
end
