class Prototype < ActiveRecord::Base
  has_many :thumbnails, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  # tags settings
  # acts_as_taggable
  acts_as_taggable_on :tags
  attr_accessor :tags

  # nested form
  accepts_nested_attributes_for :thumbnails

  # validation
  validates :title, :copy, :concept, presence: true

  class << self
    def create_prototype_data(prototype, thumbnails_data)
      if prototype.save
        # save thumbnails for both main & sub
        thumbnails_data.each do |k, v|
          if k == "main"
            prototype.thumbnails.main.create(thumbnail: v)
          else
            prototype.thumbnails.sub.create(thumbnail: v)
          end
        end

        flash[:success] = "Successfully created your prototype."
        redirect_to newest_prototypes_path
      else
        flash[:warning] = "Unfortunately failed to create."
        redirect_to new_prototype_path
      end
    end

    def update_prototype_data(prototype, prototype_data, thumbnails_data)
      if prototype.update(prototype_data)
        # reset thumbnails for update
        prototype.thumbnails.each(&:destroy)
        # save thumbnails for both main & sub
        thumbnails_data.each do |k, v|
          if k == "main"
            prototype.thumbnails.main.create(thumbnail: v)
          else
            prototype.thumbnails.sub.create(thumbnail: v)
          end
        end

        flash[:success] = "Successfully updated your prototype."
        redirect_to newest_prototypes_path
      else
        flash[:warning] = "Unfortunately failed to update."
        redirect_to edit_prototype_path
      end
    end
  end

  def posted_date
    created_at.strftime("%b %d")
  end

  def main_thumbnail
    thumbnails.main.blank? ? "noimage-big.png" : thumbnails.main.first.thumbnail.to_s
  end

  def sub_thumbnails
    thumbnails.sub.blank? ? ["noimage-big.png"] : thumbnails.sub.map(&:thumbnail)
  end

  def liked?(user)
    likes.exists?(user_id: user.id)
  end

  def get_tags
    Tag.where(name: tag_list)
  end

  def set_default_sub(i)
    self.sub_thumbnails[i].present? ? sub_thumbnails[i].to_s : "noimage.png"
  end

end
