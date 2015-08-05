class Prototypes::LikesController < ApplicationController
  # def create
  #   Like.create(like_params)
  #   @prototype = Prototype.find(like_params[:prototype_id])
  #   # redirect_to prototype_path(like_params[:prototype_id])# and return
  # end

  def update
    Like.reset_like(like_params)
    @prototype = Prototype.find(like_params[:prototype_id])
    # redirect_to prototype_path(like_params[:prototype_id])# and return
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :prototype_id)
  end

end
