class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :favourited_user, class_name: "User"
end
