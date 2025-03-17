class Chapter < ApplicationRecord
  has_many :lectures, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :overview, presence: true
end
