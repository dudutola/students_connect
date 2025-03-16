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

users_data = [
  { username: "rita", email: "rita@studentsconnect.com", name: "Rita Costiv", location: "United States" },
  { username: "tomás", email: "tomas@studentsconnect.com", name: "Tomás Gray Vasco", location: "Spain" },
  { username: "simão", email: "simao@studentsconnect.com", name: "Simão Martins", location: "Portugal" },
  { username: "miguel", email: "miguel@studentsconnect.com", name: "Miguel Rodrigues", location: "England" },
  { username: "talice", email: "talice@studentsconnect.com", name: "Talice Netos", location: "São Tomé and Príncipe" },
  { username: "diego", email: "diego@studentsconnect.com", name: "Diego Maldonado", location: "Brasil" },
  { username: "roberta", email: "roberta@studentsconnect.com", name: "Roberta Messi", location: "Colombia" },
  { username: "pedro", email: "pedro@studentsconnect.com", name: "Pedro Costa", location: "Gabon" },
  { username: "alice", email: "alice@studentsconnect.com", name: "Alice Albuquerque", location: "France" },
  { username: "tomás", email: "tomascampos@studentsconnect.com", name: "Tomás Campos", location: "Madagascar" },
  { username: "carla", email: "carla@studentsconnect.com", name: "Carla Ferrer", location: "Malta" }
]

users_data.each do |user_data|
  user = User.create!(
    username: user_data[:username],
    password: 'password',
    email: user_data[:email],
    name: user_data[:name],
    location: user_data[:country],
    avatar_url: "https://i.pravatar.cc/150?img=#{rand(1..70)}",
    provider: 'github',
    uid: SecureRandom.uuid
  )
  puts "Created user #{user.name}"
  LectureUser.create! user: user, lecture: Lecture.first
end

puts "Everything created!"
