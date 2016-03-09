class Circles::AdminNavCell < ApplicationCell

  def current_circle
    model
  end

  def action_name
    @options[:action_name]
  end

  def tab_class(key)
    'selected' if action_name == key
  end

end