class DuserAbility
  include CanCan::Ability

  def initialize duser
    can :read, :blog
    if duser.admin?
      can :access, :rails_admin
      can :read, :dashboard
      can :manage, :all
    elsif duser.founder?
      can :access, :rails_admin
      can :read, :dashboard
      can :manage, [Event, Cause]
    elsif duser.simple_user?
      can :access, :rails_admin
      can :read, :dashboard
      can [:read, :create, :update], Blog
    end
  end
end
