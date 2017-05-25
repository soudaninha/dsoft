json.array!(@callcenters) do |callcenter|
  json.extract! callcenter, :id, :client_id, :employee, :problem, :solution, :date_finish
  json.url callcenter_url(callcenter, format: :json)
end
