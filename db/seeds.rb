# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password")
             
City.create!(name: "東京",
             location_id: 1850147)
             
City.create!(name: "横浜",
             location_id: 1848354)
             
City.create!(name: "さいたま",
             location_id: 6940394)
             
City.create!(name: "千葉",
             location_id: 2113015)
             
City.create!(name: "那覇",
             location_id: 1856035)
             
60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end