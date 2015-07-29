class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @prototypes = @user.prototypes.page(params[:page]).per(3)
  end

  def edit
    redirect_to root_path, danger: "Access denied." if @user.id != current_user.id
  end

  def update
    if user.id == current_user.id
      @user.update(update_params)
      redirect_to :show, success: "Successfully updated your information."
    else
      redirect_to :edit, danger: "Bad access."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:name, :profile, :participation, :occupation)
  end
end
