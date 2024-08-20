json.extract! drop, :id, :title, :description, :project_id, :created_at, :updated_at
json.url drop_url(drop, format: :json)
