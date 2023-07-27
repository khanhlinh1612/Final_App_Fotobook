class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def active_for_authentication?
      super && self.status == "active"
  end

  def inactive_message
      "Sorry, this account has been deactivated."
  end
  enum status: {inactive: 0 , active: 1}
  # mount_uploader :avatar, AvatarUploader
  has_one_attached :avatar
  #Validate
  validates :first_name, presence: true, length: {maximum: 25}
  validates :last_name, presence: true, length: {maximum: 25}
  validates :email, presence: true,length: {maximum:255}, uniqueness:true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :password, presence: true, length: {maximum:64}
  # validates :password , confirmation: true
  #association
  has_many :photos, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :like_photos , dependent: :destroy
  has_many :like_albums , dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  after_validation :default_value
  private
    def default_value
      self.status ||= 1
      self.is_admin ||= false
    end

end

