class Meeting < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :lecture

  validates :lecture, presence: true
  validates :requester, presence: true
  validates :receiver, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :status, inclusion: { in: %w[pending confirmed declined] }

  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
