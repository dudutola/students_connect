class Meeting < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :lecture
  has_many :notifications, dependent: :destroy

  before_validation :set_default_status, on: :create

  validates :lecture, presence: true
  validates :requester, presence: true
  validates :receiver, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :status, inclusion: { in: %w[pending accepted declined] }

  validate :end_time_after_start_time

  private

  def set_default_status
    self.status ||= 'pending'
  end

  def end_time_after_start_time
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
