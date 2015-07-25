class User < ActiveRecord::Base
  # association
  has_many :prototypes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # carrierwave
  mount_uploader :avatar, ImageUploader
end
