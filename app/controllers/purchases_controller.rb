class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: %i(create)
  before_action :get_cause, only: %i(new create)

  def new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    amount = (((params[:donate][:amount]).to_f)*100).to_i
    items = [{name: t("purchase.title"), description: params[:donate][:description], quantity: 1, amount: amount}]
    express_checkout amount, new_cause_donations_url(@cause), new_cause_purchases_url(@cause), items
  end

  private
  def get_cause
    @cause = Cause.find_by_slug(params[:cause_id]) || Cause.find_by(id: params[:cause_id])
    return if @cause
    flash[:error] = t "purchase.cause.error"
    redirect_to causes_url
  end

  def express_checkout amount_in_cents, return_url, cancel_url, items
    response = EXPRESS_GATEWAY.setup_purchase(amount_in_cents,
      ip: request.remote_ip,
      return_url: return_url,
      cancel_return_url: cancel_url,
      currency: t("purchase.cause.usd"),
      allow_guest_checkout: true,
      items: items,
      no_shipping: 1
      )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
end
