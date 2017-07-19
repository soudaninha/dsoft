json.array!(@ad_users) do |ad_user|
  json.extract! ad_user, :id, :colaborador, :departamento, :user_ad, :senha, :ip, :pastas
  json.url ad_user_url(ad_user, format: :json)
end
