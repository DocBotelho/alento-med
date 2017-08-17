require 'json'
require 'open-uri'

10.times do
  trial = Trial.new(
    title: Faker::Commerce.product_name,
    condition: Faker::Commerce.promotion_code,
    description: Faker::Lorem.sentences,
    eligibility: Faker::Lorem.words)
  trial.save

  institution = Institution.new(
    name: Faker::Address.community,
    address: Faker::Address.street_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude)
  institution.save

  doctor = Doctor.new(
    name: Faker::Name.unique.name,
    phone: Faker::Company.duns_number,
    email: Faker::Internet.free_email,)
  doctor.save

  trial.institutions << Institution.last
  trial.doctors << Doctor.last
  trial.save
end

