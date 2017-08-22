class Trial < ApplicationRecord
  # Added to allow search through treatment model
  has_many :treatments, dependent: :destroy
  # Added to allow combined search through trialinstitution model
  has_many :trialinstitutions, dependent: :destroy
  # Added to allow combined search through trialinstitution model
  has_many :institutions, through: :trialinstitutions, dependent: :destroy
  # Added to allow combined search through trialdoctor model
  has_many :trialdoctors, dependent: :destroy
  # Added to allow combined search through trialdoctor model
  has_many :doctors, through: :trialdoctors, dependent: :destroy

  validates_uniqueness_of :trial_nct_id
end
