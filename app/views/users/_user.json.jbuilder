json.extract! user, :id, :name, :max_push, :max_carry, :role
json.url user_url(user, format: :json)
