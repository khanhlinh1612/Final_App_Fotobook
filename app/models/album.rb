class Album < ApplicationRecord
  enum sharing_status: {
    limited: 0,
    shared: 1,
  }
  belongs_to :user
  has_many :album_photos
  has_many :photos , :through => :album_photos
end
