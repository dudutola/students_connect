class Chapter < ApplicationRecord
  # has_many :lectures, dependent: :destroy

  validates :name, presence: true
end
