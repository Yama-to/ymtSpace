class Tag < ActsAsTaggableOn::Tag

  def prototypes_from_tag
    Prototype.tagged_with(self)
  end

end
