module CausesHelper
  def ratio cause
    cause.goal_money == 0 ? 0 : cause.reached_money*100/cause.goal_money
  end

  def render_with_hashtags detail
    detail.gsub(/#\w+/){|word| link_to word, "/tags/#{word.delete('#')}"}.html_safe
  end
end
