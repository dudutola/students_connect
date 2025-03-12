# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Chapter.destroy_all

# Create sample chapters

Chapter.create(name: "Ruby")
Chapter.create(name: "Intermediate HTML and CSS")
Chapter.create(name: "Databases")
Chapter.create(name: "Ruby on Rails")
Chapter.create(name: "Advanced HTML and CSS")
Chapter.create(name: "JavaScript")
Chapter.create(name: "React")
Chapter.create(name: "Getting Hired")

puts "all done"