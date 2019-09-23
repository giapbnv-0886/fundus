class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
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
    user.present? and event.user == user and event.start_time > Datetime.now
  end

  def edit?
    update?
  end

  def destroy?
    event.user == user and event.start_time > Datetime.now
  end
end
