json.extract! webhook, :id, :url, :api_key, :user_id, :method, :is_active, :created_at, :updated_at
json.url webhook_url(webhook, format: :json)
