class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.order('title ASC').page(params[:page]).per(3)
  end

  def show
    @user = @prototype.user
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
      flash[:success] = "Successfully created your prototype."
      redirect_to newest_prototypes_path
    else
      flash[:warning] = "Unfortunately failed to create."
      redirect_to new_prototype_path
    end
  end

  def edit
    @tag_names = @prototype.tag_list
    if @prototype.user_id != current_user.id
      flash[:danger] = "Access denied."
      redirect_to root_path
    end
  end

  def update
    @prototype.tag_list = tags_params
    if prototype.update(prototype_params)
      prototype.thumbnails.each(&:destroy)
      prototype.create_thumbnails_data(thumbnails_params)
      flash[:success] = "Successfully updated your prototype."
      redirect_to newest_prototypes_path
    else
      flash[:warning] = "Unfortunately failed to update."
      redirect_to edit_prototype_path
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
