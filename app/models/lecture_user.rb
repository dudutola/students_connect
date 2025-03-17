class LectureUser < ApplicationRecord
  belongs_to :user
  belongs_to :lecture

  validates :user, :lecture, presence: true
  validates :user, uniqueness: { scope: :lecture }
end
