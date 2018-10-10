class ClockEvent < ApplicationRecord
  before_create :generate_time_logged
  before_validation :store_time_logged_before_first_validation

  validates :name, presence: true, length: {maximum: 92}, allow_nil: false
  validates :clocking_in, inclusion: [true, false], allow_nil: false
  validates :time_logged, presence: true, allow_nil: false

  private
    def generate_time_logged
      self.time_logged = DateTime.now
    end

    def store_time_logged_before_first_validation
      # since we validate that the time_logged is present, when we create a 
      # new clock event, the time_logged is not passed to the backend because
      # it is generated on the backend, which will cause instance to be
      # invalid and not save (since it doesn't exist yet) ...
      # work around this by filling in a temporary time_logged (before the
      # 'before_create' hook) so that a newclock event will validate ...
      # only do it if the id of the clock event is nil, which means we are
      # creating a new clock event instance ...
      # if we are updating, the time_logged exists, and id exists, and we
      # should NOT generate a new time_logged
      if self.id == nil
        generate_time_logged
      end
    end
end
