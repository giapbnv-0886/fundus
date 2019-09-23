class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  def rails_admin?(action)
    case action
    when :dashboard
      user.admin? or user.founder?
    when :index
      user.admin?
    when :show
      user.admin?
    when :new
      user.admin?
    when :edit
      user.admin?
    when :destroy
      user.admin?
    when :export
      user.admin?
    when :history
      user.admin?
    when :show_in_app
      user.admin?
    else
      raise ::Pundit::NotDefinedError, t("application.policy.error", action: action, record: record)
    end
  end

  def attributes_for(action)
  end

end
