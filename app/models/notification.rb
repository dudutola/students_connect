class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :meeting

  scope :unread, -> { where(read: false) }

  # Set the default read status to false for new notifications
  after_initialize :set_default_read_status, if: :new_record?

  def set_default_read_status
    self.read = false if self.read.nil?
  end

  # Broadcast the unread notification count when a new notification is created
  after_create_commit do
    broadcast_replace_to "notifications_#{user.id}",
                         target: "notification-count",
                         partial: "notifications/count",
                         locals: { count: user.notifications.unread.count }

    # Broadcast the updated dropdown list
    broadcast_replace_to "notifications_dropdown_#{user.id}",
                         target: "notification-dropdown",
                         partial: "notifications/dropdown",
                         locals: { notifications: user.notifications.unread }
  end
end
