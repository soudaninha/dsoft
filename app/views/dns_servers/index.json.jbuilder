json.array!(@dns_servers) do |dns_server|
  json.extract! dns_server, :id, :email, :password, :dns, :client_id
  json.url dns_server_url(dns_server, format: :json)
end
