class ClockEvent < ApplicationRecord
  before_create :generate_time_logged
  validates :name, presence: true, length: {maximum: 92}, allow_nil: false

  private
    def generate_time_logged
      self.time_logged = DateTime.now
    end
end
