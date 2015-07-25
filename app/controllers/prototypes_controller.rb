class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.order('title ASC').page(params[:page]).per(3)
  end

  def show
    @prototype = Prototype.find(params[:id])
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
      # save thumbnails for both main & sub
      thumbnails_params.each do |k, v|
        if k == "main"
          prototype.thumbnails.main.create(thumbnail: v)
        else
          prototype.thumbnails.sub.create(thumbnail: v)
        end
      end

      flash[:success] = "Successfully created your prototype."
      redirect_to newest_prototypes_path
    else
      flash[:warning] = "Unfortunately failed to save."
      render :new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    @tag_names = @prototype.tag_list
    if @prototype.user_id != current_user.id
      flash[:danger] = "Access denied."
      redirect_to root_path
    end
  end

  def update
    binding.pry
    prototype = Prototype.find(params[:id])
    prototype.tag_list = tags_params
    if prototype.update(prototype_params)
      # reset thumbnails for update
      prototype.thumbnails.each(&:destroy)
      # save thumbnails for both main & sub
      thumbnails_params.each do |k, v|
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
      render :edit
    end
  end

  def newest
    @prototypes = Prototype.order('created_at DESC').page(params[:page]).per(3)
    render :index
  end

  def popular
    @prototypes = Prototype.order('likes_count DESC').page(params[:page]).per(3)
    render :index
  end

  private

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
