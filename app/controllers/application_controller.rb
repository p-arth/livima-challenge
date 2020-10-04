class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  protected

  def configure_permitted_parameters
    # campos adicionais no cadastro
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :cargo, :salário])

    # campos adicionais a se mudar na edição do cadastro
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :cargo, :salário])
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def user_not_authorized
    redirect_to root_path, notice: "Você não tem permissão de acesso."
  end

end
