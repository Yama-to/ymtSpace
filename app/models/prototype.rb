class Prototype < ActiveRecord::Base
  has_many :thumbnails,  dependent: :destroy
  has_many :comments,    dependent: :destroy
  has_many :likes,       dependent: :destroy
  belongs_to :user

  # tags settings
  acts_as_taggable_on :tags
  attr_accessor :tags

  # nested form
  accepts_nested_attributes_for :thumbnails

  # validation
  validates :title, :copy, :concept, presence: true

  scope :prototype_pager, ->(col: 'id', order: 'DESC', page_num: 0){ order("#{col} #{order}").page(page_num).per(12).includes(:user) }

  def create_thumbnails_data(thumbnails_data)
    thumbnails_data.each { |k, v| k == "main" ? thumbnails.main.create(thumbnail: v) : thumbnails.sub.create(thumbnail: v) }
  end

  def update_thumbnails_data(thumbnails_data)
    thumbnails.each(&:destroy)
    create_thumbnails_data(thumbnails_data)
  end

  def main_thumbnail
    thumbnails.main.blank? ? "noimage-big.png" : thumbnails.main.first.thumbnail.to_s
  end

  def sub_thumbnails
    thumbnails.sub.blank? ? ["noimage-big.png"] : thumbnails.sub.map(&:thumbnail)
  end

  def set_default_sub(i)
    self.sub_thumbnails[i].present? ? sub_thumbnails[i].to_s : "noimage.png"
  end

  def posted_date
    created_at.strftime("%b %d")
  end

  def liked?(user)
    likes.exists?(user_id: user.id)
  end

  def user_avatar
    user.avatar_url(:thumb)
  end

  def user_name
    user.name
  end

  def get_tags
    Tag.where(name: tag_list)
  end

  def set_tag_value(i)
    get_tags[i] || ""
  end

  def comments_of_users
    comments.includes(:user)
  end

  def set_user_info
    if user.participation.present? && user.occupation.present?
      "#{user.participation} ／ #{user.occupation}"
    elsif user.participation.present? && user.occupation.blank?
      "#{user.participation}"
    elsif user.participation.blank? && user.occupation.present?
      "#{user.occupation}"
    else
      "- No data -"
    end
  end
end
