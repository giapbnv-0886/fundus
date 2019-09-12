# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize duser
    can :read, :all
    return unless duser.present? && duser.admin?
    can :access, :rails_admin
    can :read, :dashboard
    if duser.admin?
      can :manage, :all
    elsif duser.founder?
      can :manage, %i(event foundation)
    elsif duser.simple_user?
      can :update, :blog
    end
  end
end
