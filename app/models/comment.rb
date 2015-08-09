class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :prototype, counter_cache: :comments_count

  # validation
  validates :text, presence: true

  def avatar_thumbnail
    user.avatar_url(:thumb)
  end

  def user_name
    user.name
  end
end
