module CausesHelper
  def ratio cause
    cause.goal_money == 0 ? 0 : cause.reached_money*100/cause.goal_money
  end
end
