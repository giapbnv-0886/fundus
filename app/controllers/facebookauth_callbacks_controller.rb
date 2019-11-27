class FacebookauthCallbacksController < ApplicationController
  require "FbAuth/client"

  def new
    redirect_uri = success_facebookauth_callback_url
    cancel_uri = failure_facebookauth_callback_url
    csrf_protect_token = Devise.friendly_token[0, 20]
    session["FacebookAuth_csrf_token"] = csrf_protect_token
    redirect_to "#{FacebookClient::AUTHORIZE_URL}?client_id=#{ENV["APP_ID"]}&redirect_uri=#{redirect_uri}&cancel_uri=#{cancel_uri}&auth_type=rerequest&state=#{csrf_protect_token}&scope=email"
  end

  def success
    redirect_to failure_facebookauth_callback_path unless token_valid? params[:state]
    client = FacebookClient.new ENV["APP_ID"], ENV["APP_SECRET"]
    fields = ["id", "name", "email", "picture", "first_name", "last_name", "link", "website", "gender"]
    redirect_uri = success_facebookauth_callback_url
    code = params[:code]
    hash_token = client.get_token_from code, redirect_uri
    access_token = hash_token["access_token"]
    if client.is_valid? access_token
      raw_info = client.get_info_from access_token, fields
      process_data_user raw_info
    end
  end

  def failure
    redirect_to root_path
  end

  private
  def process_data_user raw_info
    auth_data = FacebookClient.parse_info_from raw_info
    @user = User.from_fbauth(auth_data)
    if @user.persisted?
      sign_in_and_redirect  @user, event: :authentication
    else
      session["devise.facebook_data"] = auth_data
      redirect_to new_user_registration_url
    end
  end

  def token_valid? csrf_token
    return unless session["FacebookAuth_csrf_token"] == csrf_token
    true
  end
end
