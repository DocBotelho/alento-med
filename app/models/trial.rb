class Trial < ApplicationRecord
  # Added to allow search through treatment model
  has_many :treatments
  # Added to allow combined search through trialinstitution model
  has_many :trialinstitutions
  # Added to allow combined search through trialinstitution model
  has_many :institutions, through: :trialinstitutions
  # Added to allow combined search through trialdoctor model
  has_many :trialdoctors
  # Added to allow combined search through trialdoctor model
  has_many :doctors, through: :trialdoctors
end
