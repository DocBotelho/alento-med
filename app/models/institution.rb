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
  geocoded_by :address
  #after_validation :geocode, if: :address_changed?

  validates_uniqueness_of :facility_id

  paginates_per 5

  include PgSearch
  pg_search_scope :condition_search, :associated_against => {
    :trials => :condition
  }

end

def gmaps4rails_marker_picture
 {
  "picture" => "/image/logo 02.png",          # string,  mandatory
   "width" =>  32,          # integer, mandatory
   "height" => 32,          # integer, mandatory
                         # See doc here: http://google-maps-utility-library-v3.googlecode.com/svn/trunk/richmarker/docs/reference.html
 }
end
