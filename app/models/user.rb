class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  has_many :lecture_users, dependent: :destroy

  has_many :requested_meetings, class_name: "Meeting", foreign_key: :requester_id, dependent: :destroy
  has_many :received_meetings, class_name: "Meeting", foreign_key: :receiver_id, dependent: :destroy

  has_many :reviews, dependent: :destroy  # Reviews received
  has_many :given_reviews, class_name: 'Review', foreign_key: 'reviewer_id', dependent: :destroy  # Reviews given

  
  serialize :skills, Array, coder: YAML

  # Method to get average rating
  def average_rating
    reviews.average(:rating).to_f.round(1)
  end
  
  # Method to get rating as stars
  def rating_as_stars
    avg = average_rating
    full_stars = avg.floor
    half_star = (avg - full_stars) >= 0.5
    
    stars = ""
    full_stars.times { stars += "★" }
    stars += "☆" if half_star
    (5 - stars.length).times { stars += "☆" }
    
    stars
  end


  def completed_lecture?(lecture)
    return false if lecture.nil?
    
    lecture_users.exists?(lecture: lecture)
  end
  
  # Calculate percentage completion for a chapter
  def chapter_progress(chapter)
    return 0 if chapter.nil?
    
    total_lectures = chapter.lectures.count
    return 0 if total_lectures == 0
    
    completed_lectures = chapter.lectures.joins(:lecture_users)
                             .where(lecture_users: { user_id: self.id })
                             .distinct.count
    
    (completed_lectures.to_f / total_lectures * 100).round
  end
  
  # Get count of completed lectures in a chapter
  def completed_lectures_in_chapter(chapter)
    return 0 if chapter.nil?
    
    chapter.lectures.joins(:lecture_users)
           .where(lecture_users: { user_id: self.id })
           .distinct.count
  end
  
  def self.from_omniauth(access_token)
    data = access_token.info
    uid = access_token.uid
    provider = access_token.provider
    random_string = Devise.friendly_token[0, 6]
    email = data['email'].presence || "user_#{random_string}@email.com"
    location = access_token.extra.raw_info['location'].presence || ""

    user = User.find_by(provider: provider, uid: uid)

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create!(
        email: email,
        password: Devise.friendly_token[0, 20],
        username: data['nickname'],
        name: data['name'],
        avatar_url: data['image'],
        location: location,
        bio: data['bio'],
        provider: provider,
        uid: uid
      )
    end
    user
  end
end
