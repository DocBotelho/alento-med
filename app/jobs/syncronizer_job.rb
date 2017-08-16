class SyncronizerJob < ApplicationJob
  queue_as :default

  def perform
    Study.joins("INNER JOIN facilities ON facilities.nct_id = studies.nct_id INNER JOIN facility_investigators ON facility_investigators.facility_id = facilities.id INNER JOIN facility_contacts ON facility_contacts.facility_id = facilities.id INNER JOIN conditions ON conditions.nct_id = studies.nct_id INNER JOIN calculated_values ON calculated_values.nct_id = studies.nct_id INNER JOIN designs ON designs.nct_id = studies.nct_id INNER JOIN eligibilities ON eligibilities.nct_id = studies.nct_id").where("facilities.country = 'Brazil' AND facilities.status = 'Recruiting' AND study_type = 'Interventional'").select('*')find_each do |f|

      @trial = Trial.new(params[title: f.brief_title, condition: f.name, eligibility: f.recruitment_details, description:])
      @trial.save


    #.joins('INNER JOIN participant_flows on participant_flows.nct_id = facilities.nct_id').joins('INNER JOIN result_contacts on result_contacts.nct_id = facilities.nct_id').joins('INNER JOIN result_contacts on result_contacts.nct_id = facilities.nct_id').find_each do |f|

    #select * from browse_conditions inner join facilities ON facilities.nct_id = browse_conditions.nct_id where facilities.country = 'Brazil'

  end
end
