class LikePhoto < ApplicationRecord
  validates :user_id, uniqueness: {scope: :photo_id}
  belongs_to :user
  belongs_to :photo
end
