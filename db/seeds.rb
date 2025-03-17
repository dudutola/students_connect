	# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

puts "Cleaning everything..."

User.destroy_all
Chapter.destroy_all
Lecture.destroy_all
LectureUser.destroy_all
Meeting.destroy_all

puts "Database cleaned."

10.times do
  user = User.create!(
    username: Faker::Internet.username,
    password: 'password',
    email: Faker::Internet.email,
    name: Faker::Name.name,
    location: Faker::Address.country,
    avatar_url: "https://i.pravatar.cc/150?img=#{rand(1..70)}",
    provider: 'github',
    uid: SecureRandom.uuid
  )
  puts "Created user #{user.name}"
end

filepath = File.join(__dir__, "curriculum.json")
serialized_curriculum = File.read(filepath)
chapters = JSON.parse(serialized_curriculum)

chapters.each do |chapter|
  new_chapter = Chapter.find_or_create_by!(
    name: chapter["chapter_title"],
    description: chapter["chapter_description"],
    overview: chapter["chapter_overview"]
  )
  puts "Created chapter #{new_chapter.name}"

  chapter["chapter_groups"].each do |chapter_group|
    chapter_group["group_lectures"].each do |group_lecture|
     lecture = Lecture.find_or_create_by!(
        title: group_lecture["lecture_title"],
        group_name: chapter_group["group_title"],
        resource_url: group_lecture["lecture_url"],
        chapter: new_chapter
      )

      rand(2..6).times do
        user = User.all.sample
        begin
          LectureUser.create!(user: user, lecture: lecture)
        rescue ActiveRecord::RecordInvalid => error
          puts "User #{user.name} already has this lecture"
          puts error.message
        end
      end
      puts "Created lecture #{lecture.title} in chapter #{new_chapter.name}"
    end
  end
end

puts "Everything created!"
