class Thumbnail < ActiveRecord::Base
  belongs_to :prototype

  # enum
  enum role: [:main, :sub]

  # carrierwave
  mount_uploader :thumbnail, ImageUploader
end
