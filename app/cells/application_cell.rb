require 'cell/translation'

class ApplicationCell < Cell::ViewModel
  
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TranslationHelper
  include Cell::Translation
  include Escaped
  include CanCan::ControllerAdditions
  
  # FIXME prefix i18n keys with 'cells.'
  
end