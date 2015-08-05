class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :prototype, counter_cache: :likes_count

  scope :find_or_init, ->(user_id, prototype_id){ where(user_id: user_id, prototype_id: prototype_id).first_or_initialize }
  scope :reset_like,   ->(like_data){ exists?(like_data) ? where(like_data).destroy_all : create(like_data) }

end
