RailsAdmin.config do |config|
  config.parent_controller = "ApplicationController"
  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  #  # == CancanCan ==
  # config.authorize_with :cancancan, UserAbility

  ## == Pundit ==
  config.authorize_with :pundit

  ## == method to call for current_user ==
  config.current_user_method(&:current_user)

  config.authorize_with do
    redirect_to main_app.root_path, alert: 'You are not authorized to perform this action.' unless current_user.admin?
  end
  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
