class Prototypes::CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to prototype_path(comment_params[:prototype_id]), success: "Successfully created a comment."
    else
      redirect_to :back, warning: "Unfortunately failed to save a comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :prototype_id)
  end
end
