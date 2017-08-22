class Institutiondoctor < ApplicationRecord
  belongs_to :institution
  belongs_to :doctor
end
