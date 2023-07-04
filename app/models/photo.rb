class Photo < ApplicationRecord
  enum sharing_status: {
    limited: 0,
    shared: 1,
  }
  belongs_to :user
  has_many :album_photos
  has_many :albums, through: :album_photos
end
