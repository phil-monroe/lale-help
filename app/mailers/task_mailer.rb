class TaskMailer < BaseMandrillMailer
  def task_reminder(task, user, token)
    build_message(user.language, user.email) do
      merge_vars(user, task).merge({
        "TASK_UNASSIGN_URL" => handle_token_url(token.code, status: :decline),
        "TASK_CONFIRM_URL"  => handle_token_url(token.code, status: :confirm)
      })
    end
  end


  def task_completion_reminder(task, user, token)
    build_message(user.language, user.email) do
      merge_vars(user, task).merge({
        "TASK_MARK_COMPLETE_URL" => handle_token_url(token.code, status: :completed),
        "TASK_ADD_COMMENT_URL"   => handle_token_url(token.code)
      })
    end
  end


  def task_invitation(task, user, token)
    build_message(user.language, user.email) do
      merge_vars(user, task).merge({
        "WORKGROUP"        => task.working_group.name,
        "TASK_URL"         => handle_token_url(token.code),
        "TASK_ACCEPT_URL"  => handle_token_url(token.code, status: :accept),
        "TASK_DECLINE_URL" => handle_token_url(token.code, status: :decline)
      })
    end
  end


  def task_change(task, user)
    build_message(user.language, user.email) do
      merge_vars(user, task).merge({
        "TASK_REVIEW_URL" => handle_token_url(user.login_token.code, redirect: circle_task_path(task.circle, task)),
      })
    end
  end

  def task_comment(task, comment, user)
    build_message(user.language, user.email) do
      merge_vars(user, task).merge({
        "TASK_COMMENT"    => comment.body,
        "TASK_REVIEW_URL" => handle_token_url(user.login_token.code, redirect: circle_task_path(task.circle, task)),
      })
    end
  end


  private

  def merge_vars user, task
    {
      "FIRST_NAME"            => user.first_name,
      "TASK_TITLE"            => task.name,
      "TASK_DESCRIPTION"      => task.description.truncate(100, separator: /\s/, omission: '...'),
      "TASK_DUE_DATE"         => task.due_date_and_time,
      "TASK_TIME_REQUIRED"    => task.duration_text,
      "TASK_HELPERS_REQUIRED" => task.volunteer_count_required
    }
  end
end