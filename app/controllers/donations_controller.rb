class DonationsController < ApplicationController
  before_action :authenticate_user!, only: %i(index new create)
  before_action :get_cause, except: %i(index show edit)
  before_action :get_object, :get_attributes, :correct_owner, only: %i(index)

def index
  csv = ExportCsv.new @object, @attributes
  respond_to do |format|
    format.csv { send_data csv.perform, filename: "#{t "donation.csv_name", title: @cause.title}.csv" }
  end
end


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

  def get_object
    @cause = Cause.find_by id: params[:cause_id]
    if @cause
      @object = @cause.donations.purchased
    else
      flash[:danger] = t "cause.error.notfound"
      redirect_to causes_path
    end
  end

  def get_attributes
    @attributes = Donation::CSV_ATTRIBUTES
  end

  def correct_owner
    return if @cause.belong? current_user
    flash[:danger] = t "cause.error.notfound"
    redirect_to causes_path
  end
end
