	# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

LectureUser.destroy_all
Lecture.destroy_all
Chapter.destroy_all
User.destroy_all
puts "Cleaning everything..."

# Create sample chapters

Chapter.create(name: "Ruby")
Chapter.create(name: "Intermediate HTML and CSS")
Chapter.create(name: "Databases")
Chapter.create(name: "Ruby on Rails")
Chapter.create(name: "Advanced HTML and CSS")
Chapter.create(name: "JavaScript")
Chapter.create(name: "React")
Chapter.create(name: "Getting Hired")


ruby_chapter = Chapter.find_by(name: "Ruby")

puts "Creating lectures..."
lectures = [
  # Introduction group
  { title: "How This Course Will Work", group_name: "Introduction" },
  { title: "Installing Ruby", group_name: "Introduction" },

  # Basic Ruby group
  { title: "Basic Data Types", group_name: "Basic Ruby" },
  { title: "Variables", group_name: "Basic Ruby" },
  { title: "Input and Output", group_name: "Basic Ruby" },
  { title: "Conditional Logic", group_name: "Basic Ruby" },
  { title: "Loops", group_name: "Basic Ruby" },
  { title: "Arrays", group_name: "Basic Ruby" },
  { title: "Hashes", group_name: "Basic Ruby" },
  { title: "Methods", group_name: "Basic Ruby" },
  { title: "Debugging", group_name: "Basic Ruby" },
  { title: "Basic Enumerable Methods", group_name: "Basic Ruby" },
  { title: "Predicate Enumerable Methods", group_name: "Basic Ruby" },
  { title: "Nested Collections", group_name: "Basic Ruby" },

  # Basic Ruby Projects group
  { title: "Basic Ruby Projects", group_name: "Basic Ruby Projects" },
  { title: "Project: Caesar Cipher", group_name: "Basic Ruby Projects" },
  { title: "Project: Sub Strings", group_name: "Basic Ruby Projects" },
  { title: "Project: Stock Picker", group_name: "Basic Ruby Projects" },
  { title: "Project: Bubble Sort", group_name: "Basic Ruby Projects" }
]

lectures.each do |lecture_data|
  Lecture.create!(lecture_data.merge(chapter_id: ruby_chapter.id))
end

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

  LectureUser.create! user: user, lecture: Lecture.first
  puts "Created user #{user.name}"
end

puts "Everything created!"
