json.array!(@scools) do |scool|
  json.extract! scool, :id, :scool
  json.url scool_url(scool, format: :json)
end
