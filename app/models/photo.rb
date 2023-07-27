class Photo < ApplicationRecord
  validates :title , presence:true ,length: {maximum:140}
  validates :description , presence:true,length: {maximum:300}
  validates :sharing_status , presence:true
  validates :image , presence: true
  enum sharing_status: {
    limited: 0,
    shared: 1,
  }
  belongs_to :user
  has_many :album_photos
  has_many :albums, through: :album_photos
  has_many :like_photos, dependent: :destroy
  has_one_attached :image
  # mount_uploader :image, ImageUploader
  before_destroy :delete_image
  after_validation :default_value
  private
    def default_value
      self.sharing_status ||= 1
    end
    def delete_image
      self.image.purge
    end
end
