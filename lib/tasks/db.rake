namespace :db do
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
    Location.create!(name: 'Christchurch')
    Location.create!(name: 'Wellington')
    Location.create!(name: 'Auckland')
    Location.create!(name: 'Dunedin')
    Location.create!(name: 'Hamilton')
    Location.create!(name: 'Nelson')
    Location.create!(name: 'Westport')
    Location.create!(name: 'Karamea')
    Location.create!(name: 'Picton')
    Location.create!(name: 'Copenhagen')
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
