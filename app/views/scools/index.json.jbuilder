json.array!(@scools) do |scool|
  json.extract! scool, :id, :name
  json.url scool_url(scool, format: :json)
end
