class Meeting < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :lecture
  has_many :notifications, dependent: :destroy

  before_validation :set_default_status, on: :create
  after_update :create_status_change_notification, if: :status_changed?

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

  def create_status_change_notification
    message = case status
              when 'accepted'
                "#{requester.name} accepted your meeting request at #{start_time.strftime('%I:%M %p')}"
              when 'declined'
                "#{requester.name} declined your meeting request at #{start_time.strftime('%I:%M %p')}"
              else
                "#{requester.name} requested a meeting at #{start_time.strftime('%I:%M %p')}"
              end

    Notification.create(user: receiver, message: message, meeting: self)
    Notification.create(user: requester, message: message, meeting: self)
  end
end
