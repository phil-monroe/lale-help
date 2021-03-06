class Circle::UpdateExtendedSettingsForm < Circle::BaseForm

  def redirect_path
    extended_settings_circle_admin_path(circle)
  end

  def view_for_error
    'circle/admins/extended_settings'
  end

  class Submit < Circle::BaseForm::Submit

    def execute
      circle.assign_attributes inputs.slice(:must_activate_users)
      circle.save
      circle
    end
    
  end
end