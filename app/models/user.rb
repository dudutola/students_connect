class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  has_many :lecture_users, dependent: :destroy

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
