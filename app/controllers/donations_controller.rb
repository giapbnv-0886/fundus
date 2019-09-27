class DonationsController < ApplicationController
  before_action :authenticate_user!, only: %i(new create)
  before_action :get_cause, except: %i(index show edit)

  def new
    @donation = @cause.donations.build token: params[:token]
  end

  def create
    @donation = @cause.donations.build donation_params
    if @donation.save
      if @donation.purchase
        flash[:info] = t "donation.alert.success", amount: @donation.amount, cause: @cause.title
        redirect_to cause_path @cause
      else
        @donation.destroy
        flash[:danger] = t "donation.alert.error"
        redirect_to cause_path @cause
      end
    else
      render :new
    end
  end

  private
  def get_cause
    @cause = Cause.find_by id: params[:cause_id]
    return if @cause
    flash[:danger] = t "donation.cause.error"
    redirect_to causes_url
  end

  def donation_params
    (params.require(:donation).permit(:token)).reverse_merge!({user_id: current_user.id})
  end
end
