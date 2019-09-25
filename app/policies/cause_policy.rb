class CausePolicy < ApplicationPolicy
  attr_reader :user, :cause

  def initialize(user, cause)
    @user = user
    @cause = cause
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? and user.founder?
  end

  def new?
    create?
  end

  def update?
    user.present? and cause.user == user and cause.start_time > Datetime.now
  end

  def edit?
    update?
  end

  def destroy?
    cause.user == user and cause.start_time > Datetime.now
  end
end
