class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @prototypes = @user.prototypes.prototypes_pager(page_num: params[:page])
  end

  def edit
    redirect_to root_path, danger: "Access denied." if @user.id != current_user.id
  end

  def update
    if @user.id == current_user.id
      @user.update(update_params)
      redirect_to user_path(@user), success: "Successfully updated your information."
    else
      redirect_to edit_user_path(@user), danger: "Bad access."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:name, :profile, :participation, :occupation, :avatar)
  end
end
