class BlogPolicy < ApplicationPolicy
  attr_reader :user, :blog

  def initialize(user, blog)
    @user = user
    @blog = blog
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    blog.user == user
  end

  def edit?
    update?
  end

  def destroy?
    blog.user == user
  end
end
