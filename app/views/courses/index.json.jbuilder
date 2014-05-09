json.array!(@courses) do |course|
  json.extract! course, :id, :course
  json.url course_url(course, format: :json)
end
