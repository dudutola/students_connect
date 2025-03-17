class Availability < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, presence: true
  validate :start_time_before_end_time

  private

  def start_time_before_end_time
    if start_time.present? && end_time.present? && start_time >= end_time
      errors.add(:start_time, "must be before the end time")
    end
  end
end
