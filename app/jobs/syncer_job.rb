class SyncerJob < ApplicationJob
  queue_as :default

  def perform

    Study.joins("INNER JOIN facilities ON facilities.nct_id = studies.nct_id INNER JOIN facility_investigators ON facility_investigators.facility_id = facilities.id INNER JOIN facility_contacts ON facility_contacts.facility_id = facilities.id INNER JOIN conditions ON conditions.nct_id = studies.nct_id INNER JOIN designs ON designs.nct_id = studies.nct_id INNER JOIN eligibilities ON eligibilities.nct_id = studies.nct_id INNER JOIN brief_summaries ON brief_summaries.nct_id = studies.nct_id LEFT OUTER JOIN links ON links.nct_id = studies.nct_id").where("facilities.country = 'Brazil' AND facilities.status = 'Recruiting' AND study_type = 'Interventional'").select("studies.brief_title as brief_title, conditions.name as condition_name, brief_summaries.description as brief_summary, eligibilities.criteria as criteria, facilities.name as facility_name, facilities.city as facility_city, facilities.state as facility_state, facilities.country as facility_country, facilities.zip as facility_zip, facility_contacts.name as contact_name, facility_contacts.email as contact_email, facility_contacts.phone as contact_phone, links.url as study_link, facility_investigators.name as doctor_name").each do |f|

      if Trial.exists?(title: f.brief_title, condition: f.condition_name,description: f.brief_summary, eligibility: f.criteria, link: f.study_link)
      else
        trial = Trial.new(title: f.brief_title, condition: f.condition_name,description: f.brief_summary, eligibility: f.criteria, link: f.study_link)
        trial.save
      end

       Institution.find_or_create(name: f.facility_name
        institution = Institution.new(name: f.facility_name, address: [f.facility_name, f.facility_city, f.facility_state, f.facility_country, f.facility_zip].join(", "))
          institution.save

      if Doctor.exists?(name: f.doctor_name, contactname: f.contact_name)
      else
      contact = Doctor.new(name: f.doctor_name, email: f.contact_email, phone: f.contact_phone, contactname: f.contact_name)
      contact.save

      TrialInstitution.new()
      TrialDoctor.new()
      end
    end
  end
end
