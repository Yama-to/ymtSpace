class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :prototype

  def avatar_thumbnail
    user.avatar_url(:thumbnail)
  end
end
