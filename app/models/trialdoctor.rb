class Trialdoctor < ApplicationRecord
  belongs_to :trial
  belongs_to :doctor
end
