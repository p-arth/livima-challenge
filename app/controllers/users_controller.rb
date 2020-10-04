class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]
  before_action :authorize_user

  def index
    if params[:query].present?
      @searched = true
      if params[:search_filter] == "pornome"
        @users = policy_scope(User.search_by_nome(params[:query]))
      elsif params[:search_filter] == "poremail"
        @users = policy_scope(User.search_by_email(params[:query]))
      else
        @users = policy_scope(User.search_by_cargo(params[:query]))
      end
    else
      @users = policy_scope(User.all).order(created_at: :desc)
    end
  end

  def show
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
      render :edit, notice: "Ocorreu algum problema ao tentar atualizar o usuário."
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Usuário criado!" 
    else
      render :new, notice: "Ocorreu algum problema ao tentar criar o usuário."
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "Usuário excluído."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nome, :email, :password, :password_confirmation, :cargo, :salário)
  end

  def authorize_user
    if @user.nil?
      authorize User
    else
      authorize @user
    end
  end

end
  