class Duser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  public
  def simple_user?
    return true if role == 0
    false
  end

  def founder?
    return true if role == 1
    false
  end

  def admin?
    return true if role == 2
    false
  end
end
