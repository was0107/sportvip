json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :teacher
  json.url teacher_url(teacher, format: :json)
end
