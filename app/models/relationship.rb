class Relationship < ApplicationRecord
  validates :follower_id, uniqueness: {scope: :followed_id}
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
