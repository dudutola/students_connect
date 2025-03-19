class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :favourited_user, class_name: "User"

  validates :favourited_user, presence: true, uniqueness:  { scope: :user }
end
