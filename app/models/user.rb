class User < ActiveRecord::Base
  # association
  has_many :prototypes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # carrierwave
  mount_uploader :avatar, AvatarUploader

  def set_default_avatar
    avatar_url(:thumb) || "noimage.png"
  end

  def count_prototypes
    prototypes.count
  end
end
