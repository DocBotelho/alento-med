class Disease < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_portuguese, against: [ :portuguese ]

end
