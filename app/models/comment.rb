class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :prototype

  # validation
  validates :text, presence: true

  def avatar_thumbnail
    user.avatar_url(:thumb)
  end
end
