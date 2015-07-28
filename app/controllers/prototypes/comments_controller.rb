class Prototypes::CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:success] = "Successfully created a comment."
      redirect_to prototype_path(comment_params[:prototype_id])
    else
      flash[:warning] = "Unfortunately failed to save a comment."
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :prototype_id)
  end
end
