Given the code of a Ruby on Rails controller action, write a JSON schema that would represent the action as a function.

Examples:

1. A ruby controller for fetching a user from the database using the user_id then rendering a json representation fo the user.

Ruby controller action:

```ruby
    def show
      @user = User.find(params[:id])
      render json: @user
    end
```

Internal json representation:

```json
{
  "name": "show",
  "entity": "user",
  "entity_class": "User",
  "parameters": "User.id",
  "return": "user",
  "render": {
    "type": "json"
  }
}
```

JSON schema:

```json
{
  "type": "object",
  "properties": {
    "name": {
      "type": "string"
    },
    "entity": {
      "type": "string"
    },
    "entity_class": {
      "type": "string"
    },
    "parameters": {
      "type": "string"
    },
    "return": {
      "type": "string"
    },
    "render": {
      "type": "object",
      "properties": {
        "type": {
          "type": "string"
        }
      },
      "required": ["type"]
    }
  },
  "required": ["name", "entity", "entity_class", "parameters", "return", "render"]
}
```

Routing schema:

```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string"
    },
    "method": {
      "type": "string"
    },
    "parameters": {
      "type": "object",
      "properties": {
        "key": {
          "type": "string"
        },
        "value": {
          "type": "string"
        }
      },
    }
  },
  "required": ["path", "method", "parameters"]
}
```

SQL Database representation:

User fields: first_name, last_name, email



```json
{
  "type": "object",
  "properties": {
    "table": {
      "type": "string"
    },
    "fields": {
      "type": "array",
      "items": {
        "type": "string"
      }
    }
  },
  "required": ["table", "fields"]
}
```