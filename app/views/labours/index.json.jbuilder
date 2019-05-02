json.array!(@labours) do |labour|
  json.extract! labour, :id
  json.url labour_url(labour, format: :json)
end
