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
    :comment

  has_one :user
end
