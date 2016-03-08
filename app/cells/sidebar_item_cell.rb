class SidebarItemCell < ApplicationCell

  def show
    render
  end

  def text
    model
  end

  def path
    @options[:path]
  end

  def css_selector
    s =  "sidebar-item"
    s << " selected" if current_page?(path)
    s
  end

  def icon_id
    @options[:icon_id] ||= nil
  end

  def after_icon
    @options[:after_icon] ||= nil
  end

  def badge_text
    @options[:badge_text] ||= nil
  end
end