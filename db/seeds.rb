require 'faker'

10.times do

  Wiki.create!(
  
    title: Faker::HarryPotter.character,
    body: Faker::HarryPotter.quote
      
  )
end

10.times do
  
  User.create!(
      
    email: Faker::Internet.email,
    password: Faker::Pokemon.name
      
  ) 
end

puts "Seed Finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"