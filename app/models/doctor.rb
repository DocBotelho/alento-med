class Doctor < ApplicationRecord
  # Added to allow search through treatment model
  has_many :treatments
  # Added to allow combined search through trialdoctor model
  has_many :trialdoctors
  # Added to allow combined search through trialdoctor model
  has_many :trials, through: :trialdoctors
  # Added to allow combined search through institutiondoctor model
  has_many :institutions, through: :institutiondoctors
  #Added by vrw to allow a fix to doctors without fiddling with Trial and Institution models
  has_many :trialdoctors, dependent: :destroy
  has_many :institutiondoctors, dependent: :destroy
end
