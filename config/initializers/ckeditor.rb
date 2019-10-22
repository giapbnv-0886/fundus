# frozen_string_literal: true

# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  # ==> ORM configuration
  require 'ckeditor/orm/active_record'

  config.current_user_method do
    current_user
  end
  config.image_file_types = %w(jpg jpeg png gif tiff)
  config.flash_file_types = %w(swf)
  config.attachment_file_types = %w(doc docx xls odt ods pdf rar zip tar tar.gz swf)
  config.authorize_with :pundit
  config.parent_controller = "ApplicationController"

  # Asset model classes
  config.picture_model { Ckeditor::Picture }
  config.attachment_file_model { Ckeditor::AttachmentFile }

  config.default_per_page = 24

end
