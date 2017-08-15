class Institution < ApplicationRecord
  # Added for geocoding
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
