class Task::Update < Task::BaseForm
  class Submit < Task::BaseForm::Submit
    def execute
      super.tap do |outcome|
        (task.users.uniq - [ user ]).each do |outboud_user|
          next unless outboud_user.email.present?
          TaskMailer.task_change(task, outboud_user).deliver_now
        end
      end
    end
  end
end