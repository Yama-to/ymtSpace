class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes.page(params[:page]).per(3)
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:danger] = "Access denied."
      redirect_to root_path
    end
  end

  def update
    user = User.find(params[:id])
    if user.id == current_user.id
      user.update(update_params)
      flash[:success] = "Successfully updated your information."
      redirect_to action: :show
    else
      flash[:danger] = "Bad access."
      redirect_to action: :edit
    end
  end

  private

  def update_params
    params.require(:user).permit(:name, :profile, :participation, :occupation)
  end
end
