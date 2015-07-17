class Prototype < ActiveRecord::Base
  has_many :thumbnails
  belongs_to :user

  # tags
  acts_as_taggable_on :tags

  # nested form
  accepts_nested_attributes_for :thumbnails
end
