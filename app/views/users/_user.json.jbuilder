json.extract! user, :id, :name, :max_push, :max_carry
json.url user_url(user, format: :json)
