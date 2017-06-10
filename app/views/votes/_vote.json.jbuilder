json.extract! vote, :id, :user_id, :quote_id, :value, :created_at, :updated_at
json.url vote_url(vote, format: :json)
