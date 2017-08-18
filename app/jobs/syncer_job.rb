class SyncerJob < ApplicationJob
  queue_as :default

  def perform

    Study.joins("INNER JOIN facilities ON facilities.nct_id = studies.nct_id INNER JOIN central_contacts ON central_contacts.nct_id = studies.nct_id INNER JOIN browse_conditions ON browse_conditions.nct_id = studies.nct_id INNER JOIN designs ON designs.nct_id = studies.nct_id INNER JOIN eligibilities ON eligibilities.nct_id = studies.nct_id INNER JOIN brief_summaries ON brief_summaries.nct_id = studies.nct_id LEFT OUTER JOIN links ON links.nct_id = studies.nct_id").where("facilities.country = 'Brazil' AND facilities.status = 'Recruiting' AND study_type = 'Interventional'").select("studies.brief_title as brief_title, browse_conditions.mesh_term as condition_name, brief_summaries.description as brief_summary, eligibilities.criteria as criteria, facilities.name as facility_name, facilities.city as facility_city, facilities.state as facility_state, facilities.country as facility_country, facilities.zip as facility_zip, central_contacts.name as contact_name, central_contacts.email as contact_email, central_contacts.phone as contact_phone, links.url as study_link, studies.nct_id as study_nct_id, facilities.nct_id as institution_nct_id, central_contacts.nct_id as contact_nct_id").each do |f|


      trial = Trial.find_or_create_by(trial_nct_id: f.study_nct_id, condition: f.condition_name)
      unless trial.persisted?
        trial = Trial.find_or_create_by(title: f.brief_title, description: f.brief_summary, eligibility: f.criteria, link: f.study_link)
      trial.save
      end

      institution = Institution.find_or_create_by(name: f.facility_name, institution_nct_id: f.institution_nct_id, address: [f.facility_name, f.facility_city, f.facility_state, f.facility_country, f.facility_zip].join(", "))

      doctor = Doctor.find_or_create_by(name: f.contact_name, email: f.contact_email, phone: f.contact_phone, doctor_nct_id: f.contact_nct_id)
      doctor.save

      trial.doctors << doctor unless trial.doctors.include?(doctor)
      trial.institutions << institution unless trial.institutions.include?(institution)
      trial.save
    end
  end
end
