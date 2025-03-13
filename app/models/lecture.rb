 class Lecture < ApplicationRecord
  belongs_to :chapter
  has_many :lecture_users, dependent: :destroy
end
