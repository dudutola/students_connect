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

Chapter.create(name: "Ruby", description: "Fundamentals of Ruby programming language")
Chapter.create(name: "Intermediate HTML and CSS", description: "Advanced layouts and styling techniques")
Chapter.create(name: "Databases", description: "SQL, database design, and ActiveRecord")
Chapter.create(name: "Ruby on Rails", description: "MVC architecture and building web apps")
Chapter.create(name: "Advanced HTML and CSS", description: "Responsive design and CSS frameworks")
Chapter.create(name: "JavaScript", description: "DOM manipulation and ES6+ features")
Chapter.create(name: "React", description: "Component-based UI development")
Chapter.create(name: "Getting Hired", description: "Portfolio building and interview prep")

chapters_descriptions = [
  { description: "Fundamentals of Ruby programming language" },
  { description: "Advanced layouts and styling techniques" },
  { description: "SQL, database design, and ActiveRecord" },
  { description: "MVC architecture and building web apps" },
  { description: "Responsive design and CSS frameworks" },
  { description: "DOM manipulation and ES6+ features" },
  { description: "Component-based UI development" },
  { description: "Portfolio building and interview prep" },
  { description: "Fundamentals of Ruby programming language" },
  { description: "Fundamentals of Ruby programming language" },
  { description: "Fundamentals of Ruby programming language" },
  { description: "Fundamentals of Ruby programming language" },
  { description: "Fundamentals of Ruby programming language" },
]


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
