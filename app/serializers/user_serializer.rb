class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :first_name,
    :last_name,
    :full_name, # attributes will also work with custom methods
    :created_at,
    :updated_at,
  )
end
