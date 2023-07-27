class Album < ApplicationRecord
  # Validate attributes
  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :sharing_status, presence: true
  validates :photos, presence: true
  validates :photos, length: {minimum: 1, message: 'Album should have at least 1 photo defined.'}
  validates :photos, length: {maximum: 25, message: 'Album should have at most 25 photo defined.'}
  validates_associated :photos

  # Associations
  enum sharing_status: {
    limited: 0,
    shared: 1
  }

  belongs_to :user
  has_many :album_photos, dependent: :destroy
  has_one_attached :image
  has_many :photos, through: :album_photos
  accepts_nested_attributes_for :photos, :allow_destroy=> true
  has_many :like_albums, dependent: :destroy

  # Callbacks
  before_validation :default_value, on: :create
  before_destroy :delete_image

  private

  def default_value
    if photos.any?
      self.title ||= photos.first.title
      self.description ||= photos.first.description
      self.sharing_status ||= photos.first.sharing_status
    end
  end

  def delete_image
    self.image.purge
  end
end
