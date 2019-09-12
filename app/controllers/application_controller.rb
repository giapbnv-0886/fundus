class ApplicationController < ActionController::Base

  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  protect_from_forgery with: :exception
end
