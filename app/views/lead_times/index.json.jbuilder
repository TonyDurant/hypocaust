json.array!(@lead_times) do |lead_time|
  json.extract! lead_time, :id, :title, :user_id, :construction_site_id, :start_date, :end_date
  json.url lead_time_url(lead_time, format: :json)
end
