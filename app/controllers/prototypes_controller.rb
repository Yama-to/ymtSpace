class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_prototype,      only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.prototype_pager(col: 'title', order: 'ASC', page_num: params[:page])
  end

  def show
    @new_comment = Comment.new
    @like = Like.find_or_init(current_user.id, params[:id])
  end

  def new
    @prototype = Prototype.new
    @prototype.thumbnails.build
  end

  def create
    prototype = current_user.prototypes.new(prototype_params)
    prototype.tag_list << tags_params
    if prototype.save
      prototype.create_thumbnails_data(thumbnails_params)
      redirect_to newest_prototypes_path, success: "Successfully created your prototype."
    else
      redirect_to new_prototype_path, warning: "Unfortunately failed to create."
    end
  end

  def edit
    @tag_names = @prototype.tag_list
    redirect_to root_path, danger: "Access denied." if @prototype.user_id != current_user.id
  end

  def update
    @prototype.tag_list = tags_params
    if prototype.update(prototype_params)
      prototype.update_thumbnails_data(thumbnails_params)
      redirect_to newest_prototypes_path, success: "Successfully updated your prototype."
    else
      redirect_to edit_prototype_path, warning: "Unfortunately failed to update."
    end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :copy, :concept)
  end

  def thumbnails_params
    params.require(:prototype).require(:thumbnails_attributes).require("0")
  end

  def tags_params
    params.require(:prototype).require(:tags).map{|k,v| v }
  end
end
