namespace :db do
  raise "Don't run this in production!" if Rails.env.production?

  desc "populates the database with users"
  task populate: :environment do
    User.destroy_all
    User.create!(
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    100.times do
      User.create!(
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password'
      )
    end
  end

  desc "populates the database with locations"
  task populate: :environment do
    Location.destroy_all
    Location.create!(name: 'Christchurch', id: 1)
    Location.create!(name: 'Wellington', id: 2)
    Location.create!(name: 'Auckland', id: 3)
    Location.create!(name: 'Dunedin', id: 4)
    Location.create!(name: 'Hamilton', id: 5)
    Location.create!(name: 'Nelson', id: 6)
    Location.create!(name: 'Westport', id: 7)
    Location.create!(name: 'Karamea', id: 8)
    Location.create!(name: 'Picton', id: 9)
    Location.create!(name: 'Copenhagen', id: 10)
  end

  desc 'Populates the database with categories'
  task populate: :environment do
    Category.destroy_all
    Category.create!(name: 'Trailers', id: 1)
    Category.create!(name: 'Excavators', id: 2)
    Category.create!(name: 'Scaffolding', id: 3)
    counter = 4
    17.times do
      Category.create!(name: Faker::Team.creature, id: counter)
      counter += 1
    end
  end

  desc "populates the database with items"
  task populate: :environment do
    Item.destroy_all
    counter = 0
    250.times do
      Item.create!(
      title: "item#{counter}",
      description: Faker::Hipster.paragraph,
      rate: Faker::Number.between(1, 700),
      specs: Faker::StarWars.quote,
      user_id: Faker::Number.between(1, 100),
      category_id: Faker::Number.between(1, 20),
      location_id: Faker::Number.between(1, 10),
      image: File.new("public/images/#{rand(1..4)}.jpg")
      )
      counter += 1
    end
  end
end
