class Facility < ActiveRecord::Base
  # self.abstract_class = true
  establish_connection (:aactdb)
  # self.table_name = "facilities"

  # def self.facilities
  #   Fetchdb.connection.execute("SELECT * FROM facilities
  #   NATURAL JOIN studies WHERE country = 'Brazil' and status = 'Recruiting' and study_type = 'Interventional';")
  # end
end
