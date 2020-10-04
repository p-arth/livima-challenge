class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        # campos adicionais no cadastro
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :cargo, :salário])

        # campos adicionais a se mudar na edição do cadastro
        devise_parameter_sanitizer.permit(:account_update, keys: [:email, :cargo, :salário])
    end
end
