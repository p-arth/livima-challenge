class UsersController < ApplicationController
  before_action :set_user, except: :update

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
    # authorize @user
  end

end
  