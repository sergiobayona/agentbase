json.type 'function'
json.function do
  json.name 'User.show'
  json.description 'retrieve a user record'
  json.parameters do
    json.type 'object'
    json.properties do
      json.user_id do
        json.type 'string'
        json.description 'The user identifier'
      end
    end
    json.required ['user_id']
  end
end
