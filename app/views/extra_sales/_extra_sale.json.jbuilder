json.extract! extra_sale, :id, :client_id, :product, :value, :due_date, :obs, :created_at, :updated_at
json.url extra_sale_url(extra_sale, format: :json)