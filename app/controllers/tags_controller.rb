class TagsController < ApplicationController
  def index
    @tags = Tag.order('name ASC')
  end

  def show
    @tag = Tag.find(params[:id])
    @prototypes = Prototype.tagged_with(@tag.name).page(params[:page]).per(3)
  end
end
