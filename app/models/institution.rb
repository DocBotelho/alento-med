class Institution < ApplicationRecord
  # Added to allow search through treatment model
  has_many :treatments
  # Added to allow combined search through trialinstitution model
  has_many :trialistitutions
  # Added to allow combined search through trialinstitution model
  has_many :trials, through: :trialistitutions
  # Added for geocoding
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  paginates_per 5
end
