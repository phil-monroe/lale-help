class SidebarCell < ApplicationCell

  # the first parameter to the cell call is called model in here. 
  # adding the alias "circle" to clarify
  alias :circle :model

  # current_user is passed in the options in the cell call.
  def current_user
    @options[:current_user]
  end

  private :current_user, :circle

  def my_tasks_link
    item('my-tasks', my_circle_tasks_path(circle), badge_text: my_tasks_count)
  end

  def all_open_tasks_link
    item('all-open-tasks', open_circle_tasks_path(circle), badge_text: open_tasks_count)
  end

  def completed_tasks_link
    item('completed-tasks', completed_circle_tasks_path(circle))
  end

  def supplies_link
    item('supplies', circle_supplies_path(circle), badge_text: all_supplies_count)
  end

  def public_members_link
    unless can? :manage, circle
      item('public_members', public_circle_members_path(circle))
    end
  end

  def directory_link
    if can? :manage, circle
      item('directory', circle_members_path(circle))
    end
  end

  def organizers_link
    item('organizers', circle_organizers_path(circle))
  end

  def admin_link
    if can? :manage, circle
      item('admin', circle_admin_path(circle), badge_text: admin_actions_counter)
    end
  end

  def circle_has_working_groups?
    circle.working_groups.present?
  end

  private

  def my_tasks_count
    current_user.tasks.for_circle(circle).volunteered.not_completed.count
  end

  def open_tasks_count
    circle.tasks.unassigned.not_completed.select { |t| can?(:read, t) }.count
  end

  def all_supplies_count
    circle.supplies.not_completed.select { |s| can?(:read, s) }.count
  end

  def admin_actions_counter
    circle.pending_members.count 
  end

  def working_group_counter(working_group)
    working_group.tasks.not_completed.count + working_group.supplies.not_completed.count
  end

  # FIXME DRY
  def current_users_working_groups
    working_groups_per_user(:include?).each do |wg|
      if wg.persisted? && can?(:read, wg)
        after_icon = 'fa fa-lock' if wg.is_private?
        item = item(wg.name, circle_working_group_path(circle, wg), badge_text: working_group_counter(wg), after_icon: after_icon)
        yield item
      end
    end
  end

  # FIXME DRY
  def other_users_working_groups
    working_groups_per_user(:exclude?).each do |wg|
      if wg.persisted? && can?(:read, wg)
        after_icon = 'fa fa-lock' if wg.is_private?
        item = item(wg.name, circle_working_group_path(circle, wg), badge_text: working_group_counter(wg), after_icon: after_icon)
        yield item
      end
    end
  end

  def working_groups_per_user(check_method)
    circle.working_groups.select do |wg|
      current_user.working_groups.map(&:id).send(check_method, wg.id)
    end
  end

  def item(name, path, opts={})
    cell(:sidebar_item, t(".#{name}"), {path: path}.merge(opts)).()
  end
  
end
