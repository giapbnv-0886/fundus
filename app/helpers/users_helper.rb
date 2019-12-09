module UsersHelper
  def donations_data_by_week user
    data = []
    Category.all.each do |category|
      data.append({ name: t("chart.amount_for", name: category.name), chart_type: "column", data_link: user_donation_by_weeks_url(user, params:{category_id: category.id}) })
    end
    data.append({ name: t("chart.cause.total_amount"), chart_type: "spline", data_link: user_total_donation_by_weeks_url(user) })
  end

  def donations_data_by_month user
    data = []
    Category.all.each do |category|
      data.append({ name: t("chart.amount_for", name: category.name), chart_type: "column", data_link: user_donation_by_months_url(user, params:{category_id: category.id}) })
    end
    data.append({ name: t("chart.cause.total_amount"), chart_type: "spline", data_link: user_total_donation_by_months_url(user) })
  end
end
