class Institution < ApplicationRecord
  # Added to allow search through treatment model
  has_many :treatments
  # Added to allow combined search through trialinstitution model
  has_many :trialinstitutions
  # Added to allow combined search through trialinstitution model
  has_many :trials, through: :trialinstitutions
  # Added to allow combined search through institutiondoctor model
  has_many :institutiondoctors
  has_many :doctors, through: :institutiondoctors
  # Added for geocoding
  #geocoded_by :address
  #after_validation :geocode, if: :address_changed?

  validates_uniqueness_of :facility_id

  paginates_per 5
end
