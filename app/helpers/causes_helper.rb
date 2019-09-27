module CausesHelper
  def ratio cause
    if cause.goal_money == 0
      return 0;
    else
      cause.reached_money*100/cause.goal_money
    end
  end
end
