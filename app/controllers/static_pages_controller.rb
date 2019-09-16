class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: %i(about)

  def about
  end

  def contact
  end

  def help
  end

  def index
  end
end
