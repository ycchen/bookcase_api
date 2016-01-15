# based on the JSON API documentation shows that JSON API requires use of the JSON API media type (application/vnd.api+json) for exchanging data.
# BUT for some reason that it does not like application/vnd.api+json, so I have to go back to use application/json media type in rspec test for POST and PUT
# api_mime_types = %W(
#   application/vnd.api+json
#   text/x-json
#   application/json
# )

# Mime::Type.unregister :json
# Mime::Type.register 'application/json', :json, api_mime_types

ActiveModel::Serializer.config.adapter = ActiveModel::Serializer::Adapter::JsonApi
# ActiveModel::Serializer.config.adapter = :json