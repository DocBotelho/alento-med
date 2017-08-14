class Treatment < ApplicationRecord
  belongs_to :user
  belongs_to :trial
  belongs_to :institution
  belongs_to :doctor
end
