json.extract! message, :id, :message, :inbox_id, :created_at, :updated_at
json.url message_url(message, format: :json)
