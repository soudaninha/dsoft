json.array!(@licences) do |licence|
  json.extract! licence, :id, :client_id, :serial_bios, :type_licence, :price
  json.url licence_url(licence, format: :json)
end
