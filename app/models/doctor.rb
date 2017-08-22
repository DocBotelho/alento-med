class Doctor < ApplicationRecord
  # Added to allow search through treatment model
  has_many :treatments
  # Added to allow combined search through trialdoctor model
  has_many :trialdoctors
  # Added to allow combined search through trialdoctor model
  has_many :trials, through: :trialdoctors
  # Added to allow combined search through institutiondoctor model
  has_many :institutions, through: :institutiondoctors
end
