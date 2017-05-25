json.array!(@cad_emails) do |cad_email|
  json.extract! cad_email, :id, :email, :senha_email, :skype, :senha_skype
  json.url cad_email_url(cad_email, format: :json)
end
