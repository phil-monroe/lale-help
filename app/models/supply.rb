class Supply < ActiveRecord::Base
  include Completable
  include Taskable

  # Associations
  belongs_to :location

  def volunteer
    volunteers.first
  end

end
