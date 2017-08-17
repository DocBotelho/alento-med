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

10.times do
  a = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
  Trialinstitution.create!(
    trial_id: 1,
    institution_id: a.sample)
end

5.times do
  a = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
  Trialdoctor.create!(
  trial_id: 1,
  doctor_id: a.sample)
end

