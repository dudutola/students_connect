class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true

  def self.average_rating_for(user_id)
    where(user_id: user_id).average(:rating).to_f.round(1)
  end
  
end



