class CheckinSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :name,
    :latitude,
    :longitude,
    :address,
    :photo,
    :comment,
    :created_at,
    :updated_at

  has_one :user
end
