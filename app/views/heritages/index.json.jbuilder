json.array!(@heritages) do |heritage|
  json.extract! heritage, :id, :description, :type_contract, :client_id
  json.url heritage_url(heritage, format: :json)
end
