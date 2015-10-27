class CheckinSerializer < ActiveModel::Serializer
  cached
  delegate :cache_key, to: :object
  
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
