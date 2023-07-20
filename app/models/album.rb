class Album < ApplicationRecord
  # Validate attributes
  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :sharing_status, presence: true
  validates :photos, presence: true
  validates_associated :photos
  # Associations
  enum sharing_status: {
    limited: 0,
    shared: 1
  }

  belongs_to :user
  has_many :album_photos, dependent: :destroy
  mount_uploader :image, ImageUploader

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
    remove_image!
  end
end
