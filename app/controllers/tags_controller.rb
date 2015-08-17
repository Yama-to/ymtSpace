class TagsController < ApplicationController
  def index
    @tags = Tag.order('name ASC')
  end

  def show
    @tag = Tag.find(params[:id])
    @prototypes = Prototype.tagged_with(@tag.name).prototypes_pager(page_num: params[:page])
  end
end
