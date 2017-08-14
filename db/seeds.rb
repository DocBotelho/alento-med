require 'json'
require 'open-uri'

10.times do
  Institution.create!(
    name: Faker::Address.community,
    address: Faker::Address.street_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude)
end

10.times do
  Doctor.create!(
    name: Faker::Name.unique.name,
    phone: Faker::Company.duns_number,
    email: Faker::Internet.free_email,)
end

10.times do
  Trial.create!(
    title: Faker::Commerce.product_name,
    condition: Faker::Commerce.promotion_code,
    description: Faker::Lorem.sentences,
    eligibility: Faker::Lorem.words)
end

