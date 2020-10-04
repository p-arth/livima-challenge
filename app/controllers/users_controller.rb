class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path, notice: "Usuário atualizado."
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Usuário criado!" 
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "Usuário excluído."
  end

  private

  def set_user
    @user = User.find(params[:id])
    # authorize @user
  end

  def user_params
    params.require(:user).permit(:nome, :email, :password, :password_confirmation, :cargo, :salário)
  end

end
  