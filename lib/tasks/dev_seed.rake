namespace :dev_seed do
  desc "TODO"
  task seeddb: :environment do
    name_arr = [
  "Nancy", "Elizabeth", "Louise", "Gary", "Amy",
  "Ernest", "Tammy", "Steven", "Bruce", "Lenny",
  "Cynthia", "Alex", "Joseph", "John", "Carlos",
  "Benjamin", "Janet", "Cheryl", "Richard", "Walter",
  "Stephan", "Phyllis", "Lawrence", "Rebecca", "Nicholas",
  "Brian", "Harold", "Virginia", "Micheal", "Jacqueline"
]

name_arr.each do |person|
  u = User.new(
    name: "#{person}",
    email: "#{person}@gmail.com",
    password: "password"
  )
  u.save!(:validate => false)
  puts "#{person} added"
end


event = Event.new(
  name: "Launch Academy Social Path Demo",
  location: "Mission Control",
  address: "33 Harrison Ave #501.",
  city: "Boston",
  state: "MA",
  zipcode: "02111",
  question: "Who would are your favorite people to pair program?",
  passphrase: "TEST",
  description: "This is an event created for the purpose of demoing this web app",
  user_id: 1
)
event.save!(:validate => false)

n = 1
30.times do
  a = Attendee.new(
    user_id: n,
    event_id: 1
  )
  n += 1
  puts "Attendee added"
  a.save!(:validate => false)
end

p = 1
30.times do
  first_connection = Pick.new(
    user_id: p,
    event_id: 1,
    value: 1,
    picked_user_id: rand(1..30)
    )
  first_connection.save!(:validate => false)
  second_connection = Pick.new(
    user_id: p,
    event_id: 1,
    value: 1,
    picked_user_id: 1
    )
  second_connection.save!(:validate => false)
  third_connection = Pick.new(
    user_id: p,
    event_id: 1,
    value: 1,
    picked_user_id: rand(1..30)
    )
  third_connection.save!(:validate => false)
  p += 1
  puts "User connection created."
end

  end

end
