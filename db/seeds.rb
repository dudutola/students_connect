# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"
require "open-uri"

puts "Cleaning everything..."

User.destroy_all
Chapter.destroy_all
Lecture.destroy_all
LectureUser.destroy_all
Meeting.destroy_all
Notification.destroy_all
Review.destroy_all
Favourite.destroy_all

puts "Database cleaned."

users_data = [
  { username: "rita", email: "rita@studentsconnect.com", name: "Rita Costiv", location: "United States", description: "Hey there! Still figuring out JavaScript but I'd be happy to help with your CSS challenges! My background in painting gives me a good eye for layouts and color theory. Always looking to trade knowledge—you help me with JS logic, I'll make your site look amazing!"  },
  { username: "tomás", email: "tomas@studentsconnect.com", name: "Tomás Gray Vasco", location: "Spain", description: "What's up fellow coders! Totally new to APIs but I've gotten pretty good at responsive designs. Coming from the restaurant industry taught me to stay organized with my code. Happy to walk through CSS Grid layouts if you can help me understand how to connect to databases!" },
  { username: "simão", email: "simao@studentsconnect.com", name: "Simão Martins", location: "Portugal", description: "Learning Ruby on Rails here! Been making steady progress with backend logic but still struggling with frontend frameworks. I've got a knack for database structures though—so if you're stuck on ActiveRecord or SQL queries, I'm your guy!"
  },
  { username: "miguel", email: "miguel@studentsconnect.com", name: "Miguel Rodrigues", location: "England", description:  "Hi everyone! Just started this journey but already loving HTML/CSS. Still wrapping my head around JavaScript but I'm a quick learner! I'm great at spotting UI issues and can help review your designs. Looking for study buddies who want to tackle challenges together!"},
  { username: "talice", email: "talice@studentsconnect.com", name: "Talice Netos", location: "São Tomé and Príncipe", description: "Former teacher still learning to code! JavaScript concepts finally clicking for me, but deployment still feels like magic. Really good at explaining complex topics in simple terms—happy to help break down concepts if you can show me the ropes with testing!" },
  { username: "diego", email: "diego@studentsconnect.com", name: "Diego Maldonado", location: "Brasil", description: "Design-obsessed newbie here! Learning to code has been humbling but I've gotten the hang of UI libraries pretty quickly. Struggling with JavaScript but I can absolutely help make your projects look professional. Anyone want to trade design reviews for debugging help?" },
  { username: "roberta", email: "roberta@studentsconnect.com", name: "Roberta Messi", location: "Colombia", description: "Marathon runner tackling this coding marathon too! Getting comfortable with Node.js but CSS animations still trip me up. I'm pretty good at staying persistent with bugs—happy to help troubleshoot your code if you can explain how to make things move on the screen!"  },
  { username: "pedro", email: "pedro@studentsconnect.com", name: "Pedro Costa", location: "Gabon", description: " Multilingual and adding code to my language list! Getting the hang of vanilla JavaScript but Git workflows still confuse me. I've developed a solid debugging process that I'm happy to share! Anyone want to exchange Git tips for help with browser compatibility issues?" },
  { username: "alice", email: "alice@studentsconnect.com", name: "Alice Albuquerque", location: "France", description: "Making good progress with data visualization but backend is still a mystery to me. I've gotten pretty good at working with chart libraries—happy to help you make beautiful data displays if you can explain server-side concepts!"  },
  { username: "tomás", email: "tomascampos@studentsconnect.com", name: "Tomás Campos", location: "Madagascar", description: "Motorcycle rebuilder rebuilding my career through code! HTML structure makes perfect sense to me but I'm still learning JavaScript. I've got a methodical approach to debugging UI issues—let's help each other tackle these coding challenges!" },
  { username: "carla", email: "carla@studentsconnect.com", name: "Carla Ferrer", location: "Malta", description: " I can help spot security vulnerabilities in your projects if you can help me make things look decent with CSS!"}
]

puts "Fetching timezones for users..."

def get_user_timezone(location)
  mapbox_api = "https://api.mapbox.com/search/geocode/v6/forward?q=#{URI.encode_www_form_component(location)}&access_token=#{ENV['MAPBOX_API_KEY']}"

  first_serialized = URI.parse(mapbox_api).read
  first = JSON.parse(first_serialized)

  if first["features"].any?
    coordinates = first["features"].first["geometry"]["coordinates"].join(",")

    second_mapbox_api = "https://api.mapbox.com/v4/examples.4ze9z6tv/tilequery/#{coordinates}.json?access_token=#{ENV['MAPBOX_API_KEY']}"

    second_serialized = URI.parse(second_mapbox_api).read
    second = JSON.parse(second_serialized)

    if second["features"].any? && second["features"].first["properties"].key?("TZID")
      tzid = second["features"].first["properties"]["TZID"]
      # timezone = Timezone[tzid] rescue Timezone["UTC"]
      # return timezone.utc_to_local(Time.now)
      return tzid
    else
      puts "No timezone found for coordinates: #{coordinates}"
      return "UTC"
    end
  else
    puts "No coordinates found for location: #{location}"
    return "UTC"
  end
end

users_data.each do |user|
  puts "Fetching timezone for #{user[:name]} (#{user[:location]})..."

  timezone = get_user_timezone(user[:location])

  User.create!(
    username: user[:username],
    password: 'password',
    email: user_data[:email],
    description: user_data[:description],
    name: user_data[:name],
    location: user_data[:location],
    avatar_url: "https://i.pravatar.cc/150?img=#{rand(1..70)}",
    provider: 'github',
    uid: SecureRandom.uuid,
    timezone: timezone
  )

  puts "#{user[:name]}'s timezone is: #{timezone}"
end

puts "Timezone updates completed!"


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
