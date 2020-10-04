class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    record == user || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
