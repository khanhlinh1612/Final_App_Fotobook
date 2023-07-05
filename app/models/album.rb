class Album < ApplicationRecord

  #validate
  validates :title , presence:true ,length: {maximum:140}
  validates :description , presence:true,length: {maximum:300}
  validates :sharing_mode , presence:true
  #association
  enum sharing_status: {
    limited: 0,
    shared: 1,
  }
  belongs_to :user
  has_many :album_photos
  has_many :photos , :through => :album_photos

  after_validation :default_value
  private
    def default_value
      self.sharing_status ||= 1
    end
end
