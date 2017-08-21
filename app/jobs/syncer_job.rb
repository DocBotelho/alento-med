  class SyncerJob < ApplicationJob
  queue_as :default

  def perform

    Study.joins("INNER JOIN facilities ON facilities.nct_id = studies.nct_id  INNER JOIN browse_conditions ON browse_conditions.nct_id = studies.nct_id INNER JOIN eligibilities ON eligibilities.nct_id = studies.nct_id LEFT OUTER JOIN design_groups on design_groups.nct_id = studies.nct_id LEFT OUTER JOIN central_contacts ON central_contacts.nct_id = studies.nct_id LEFT OUTER JOIN facility_investigators ON facility_investigators.nct_id = studies.nct_id LEFT OUTER JOIN facility_contacts ON facility_contacts.nct_id = studies.nct_id").where("facilities.country = 'Brazil' AND facilities.status = 'Recruiting' AND study_type = 'Interventional'").select("studies.nct_id as study_nct_id, browse_conditions.mesh_term as condition_name, studies.brief_title as brief_title, eligibilities.gender as gender, eligibilities.maximum_age as maximum_age, eligibilities.minimum_age as minimum_age, facilities.name as facility_name, facilities.nct_id as institution_nct_id, facilities.city as facility_city, facilities.state as facility_state, facilities.country as facility_country, facilities.zip as facility_zip, central_contacts.name as central_contact_name, central_contacts.email as central_contact_email, central_contacts.phone as central_contact_phone, facility_investigators.name as facility_investigators_name, facility_investigators_role as facility_investigators_role, facility_contacts.name as facility_contacts_name, facility_contacts.email as facility_contacts_email, facility_contacts.phone as facility_contacts_phone, facilities.id as facility_id, design_groups.description as brief_description").each do |f|

      #Only create trial if the NCT_ID is not present
      trial = Trial.find_or_initialize_by(trial_nct_id: f.study_nct_id)
      #A trial can treat many conditions. Add a condition if the nct_id is present but the condition is different.
      if trial.persisted?
        if trial.condition != f.condition_name
          trial.condition += ", " + f.condition_name
          trial.save
        end
        #A trial can also have many central contacts. Do the same thing that happens with condition here
        if trial.centralcontacts != {name: f.central_contacts_name, email: f.central_contacts_email, phone: f.central_contacts_phone}
          trial.centralcontacts << {name: f.central_contacts_name, email: f.central_contacts_email, phone: f.central_contacts_phone}
          trial.save
        end
        #Create a trial with these params if there isn't one in the database
      else
        trial.title = f.brief_title
        trial.description = f.brief_description
        trial.eligibility = [f.gender, f.minimum_age, f.maximum_age].join(", ")
        trial.condition = f.condition_name
        trial.centralcontacts = [{name: f.central_contacts_name, email: f.central_contacts_email, phone: f.central_contacts_email}]
        trial.save
      end

      # Only create an Institution if there isn't one with the name and institution_id present already.
      institution = Institution.find_or_initialize_by(facility_id: f.facility_id, name: f.facility_name)
      if institution.persisted?
        if institution.centralcontacts != {name: f.facility_contacts_name, email: f.facility_contacts_email, phone: f.facility_contacts_phone}
          institution.centralcontacts << {name: f.facility_contacts_phone, email: f.facility_contacts_email, phone: f.facility_contacts_phone}
        end
      else
        institution.facility_id = f.facility_id
        institution.institutioncontacts = [{name: f.facility_contacts_name, email: f.facility_contacts_email, f.facility_contacts_phone}]
        institution.address = [f.facility_name, f.facility_city, f.facility_state, f.facility_country, f.facility_zip].join(", ")
      institution.save
      end

      #Create doctors
      doctor = Doctor.find_or_create_by(name: f.contact_name, doctor_nct_id: f.contact_nct_id)
      doctor.save

      trial.doctors << doctor unless trial.doctors.include?(doctor)
      trial.institutions << institution unless trial.institutions.include?(institution)
      trial.save
      institution.doctors << doctor unless institution.doctors.include?(doctor)
    end
  end
end



########################## PREVIOUS CODE ########################
# studies.brief_title as brief_title, browse_conditions.mesh_term as condition_name, brief_summaries.description as brief_summary, eligibilities.criteria as criteria, facilities.name as facility_name, facilities.city as facility_city, facilities.state as facility_state, facilities.country as facility_country, facilities.zip as facility_zip, central_contacts.name as contact_name, central_contacts.email as contact_email, central_contacts.phone as contact_phone, links.url as study_link, studies.nct_id as study_nct_id, facilities.nct_id as institution_nct_id, central_contacts.nct_id as contact_nct_id

#### STABLE CODE, BUT IT IS MISSING SOME STUDIES ###########
# "studies.brief_title as brief_title, conditions.name as condition_name, brief_summaries.description as brief_summary, eligibilities.criteria as criteria, facilities.name as facility_name, facilities.city as facility_city, facilities.state as facility_state, facilities.country as facility_country, facilities.zip as facility_zip, facility_contacts.name as contact_name, facility_contacts.email as contact_email, facility_contacts.phone as contact_phone, links.url as study_link, facility_investigators.name as doctor_name, studies.nct_id as study_nct_id, facilities.nct_id as institution_nct_id, facility_investigators.nct_id as doctor_nct_id")
