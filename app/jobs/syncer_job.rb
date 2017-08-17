class SyncerJob < ApplicationJob
  queue_as :default

  def perform

    Study.joins("INNER JOIN facilities ON facilities.nct_id = studies.nct_id INNER JOIN facility_investigators ON facility_investigators.facility_id = facilities.id INNER JOIN facility_contacts ON facility_contacts.facility_id = facilities.id INNER JOIN conditions ON conditions.nct_id = studies.nct_id INNER JOIN designs ON designs.nct_id = studies.nct_id INNER JOIN eligibilities ON eligibilities.nct_id = studies.nct_id INNER JOIN brief_summaries ON brief_summaries.nct_id = studies.nct_id LEFT OUTER JOIN links ON links.nct_id = studies.nct_id").where("facilities.country = 'Brazil' AND facilities.status = 'Recruiting' AND study_type = 'Interventional'").select("studies.brief_title as brief_title, conditions.name as condition_name, brief_summaries.description as brief_summary, eligibilities.criteria as criteria, facilities.name as facility_name, facilities.city as facility_city, facilities.state as facility_state, facilities.country as facility_country, facilities.zip as facility_zip, facility_contacts.name as contact_name, facility_contacts.email as contact_email, facility_contacts.phone as contact_phone, links.url as study_link, facility_investigators.name as doctor_name, studies.nct_id as study_nct_id, facilities.nct_id as institution_nct_id, facility_investigators.nct_id as doctor_nct_id").each do |f|

      trial = Trial.find_or_create_by(title: f.brief_title, condition: f.condition_name,description: f.brief_summary, eligibility: f.criteria, link: f.study_link, trial_nct_id: f.study_nct_id)
      trial.save

      institution = Institution.find_or_create_by(name: f.facility_name, institution_nct_id: f.institution_nct_id, address: [f.facility_name, f.facility_city, f.facility_state, f.facility_country, f.facility_zip].join(", "))
      institution.save

      doctor = Doctor.find_or_create_by(name: f.doctor_name, email: f.contact_email, phone: f.contact_phone, contactname: f.contact_name, doctor_nct_id: f.doctor_nct_id)
      doctor.save

      #+++++++++++++++++++++ WORKING HERE +++++++++++++++++++++++++++

      # trialdoctor = Trialdoctor.new(trial_id: trial.id, doctor_id: doctor.id).where(trial.nct_id == doctor.doctor_nct_id)

      # trialinstitution = Trialinstitution.new(trial_id: trial.id, institution_id: institution.id).where(trial.nct_id == institution.doctor_nct_id)

    end
  end
end
