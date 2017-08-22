class Syncer
  JOINS = "INNER JOIN facilities on facilities.nct_id = studies.nct_id"

  WHERE = "
     facilities.country = 'Brazil' AND
     overall_status = 'Recruiting' AND
     study_type = 'Interventional'"

  FACILITYWHERE = "
    facilities.status = 'Recruiting'"

  SELECT = "DISTINCT ON (studies.nct_id) *"

  def sync
    puts "Beginning sync..."

    Study.joins(JOINS).where(WHERE).select(SELECT).each do |study|
      trial = Trial.find_or_initialize_by(trial_nct_id: study.nct_id)
      trial.title = study.brief_title
      trial.phase = study.phase
      trial.condition = []
      trial.centralcontacts = []
      trial.save!
      puts "Trial #{trial.id} saved"
    end

    Study.joins("INNER JOIN conditions on conditions.nct_id = studies.nct_id INNER JOIN facilities on facilities.nct_id = studies.nct_id").where(WHERE).select("conditions.name as conditions_name, conditions.nct_id as conditions_nct_id").each do |condition|
      if trial = Trial.find_by(trial_nct_id: condition.conditions_nct_id)
      trial.condition << condition.conditions_name unless trial.condition.include?(condition.conditions_name)
      trial.save!
      puts "Trial condition added"
      end
    end

    Study.joins("INNER JOIN design_groups on design_groups.nct_id = studies.nct_id INNER JOIN facilities on facilities.nct_id = studies.nct_id").where(WHERE).select("design_groups.description as description, design_groups.nct_id as design_nct_id").each do |design|
      trial = Trial.find_by(trial_nct_id: design.design_nct_id)
      trial.description = design.description
      trial.save!
      puts "Added description to trial"
    end

    Study.joins("INNER JOIN eligibilities on eligibilities.nct_id = studies.nct_id INNER JOIN facilities on facilities.nct_id = studies.nct_id").where(WHERE).select("eligibilities.gender as gender, eligibilities.maximum_age as maximum_age, eligibilities.minimum_age as minimum_age, eligibilities.nct_id as eligibility_nct_id").each do |eli|
      trial = Trial.find_by(trial_nct_id: eli.eligibility_nct_id)
      trial.eligibility = [eli.gender, eli.minimum_age, eli.maximum_age].join(", ")
      trial.save!
      puts "Added eligibilities to trial"
    end

    Study.joins("INNER JOIN central_contacts on central_contacts.nct_id = studies.nct_id INNER JOIN facilities on facilities.nct_id = studies.nct_id").where(WHERE).select("central_contacts.name as central_contact_name, central_contacts.email as central_contact_email, central_contacts.phone as central_contact_phone, central_contacts.nct_id as central_contacts_nct_id").each do |central|
      if trial = Trial.find_by(trial_nct_id: central.central_contacts_nct_id)
        unless trial.centralcontacts.include?({'name' => central.central_contact_name, 'email' => central.central_contact_email, 'phone' => central.central_contact_phone})
          trial.centralcontacts << {'name' => central.central_contact_name, 'email' => central.central_contact_email, 'phone' => central.central_contact_phone}
          trial.save!
        puts "Added central contacts to trials"
        end
      end
    end

  Study.joins("INNER JOIN facilities on facilities.nct_id = studies.nct_id").where(WHERE, FACILITYWHERE).select("facilities.id as facility_id, facilities.nct_id as trial_id, facilities.name as facility_name, facilities.city as facility_city, facilities.state as facility_state, facilities.zip as facility_zip, facilities.country as facility_country").each do |facility|

    institution = Institution.find_or_initialize_by(facility_id: facility.facility_id) if trial = Trial.find_by(trial_nct_id: facility.trial_id)
    institution.name = facility.facility_name
    institution.address = [facility.facility_name, facility.facility_city, facility.facility_state, facility.facility_country, facility.facility_zip].join(", ")
    institution.institutioncontacts = []
    institution.save!
    trial.institutions << institution unless trial.institutions.include?(institution)
  end


    Study.joins("INNER JOIN facilities on facilities.nct_id = studies.nct_id INNER JOIN facility_contacts on facility_contacts.facility_id = facilities.id").where(WHERE, FACILITYWHERE).select("facility_contacts.name as facility_contacts_name, facility_contacts.email as facility_contacts_email, facility_contacts.phone as facility_contacts_phone, facility_contacts.facility_id as facility_contacts_facility_id, facility_contacts.nct_id as facility_contacts_nct_id").each do |fcontact|
      institution = Institution.find_by(facility_id: fcontact.facility_contacts_facility_id)
      unless institution.institutioncontacts.include?({'name' => fcontact.facility_contacts_name,'email' => fcontact.facility_contacts_email,'phone' => fcontact.facility_contacts_phone})
        institution.institutioncontacts << {'name' => fcontact.facility_contacts_name,'email' => fcontact.facility_contacts_email,'phone' => fcontact.facility_contacts_phone}
        institution.save!
        puts "Added contact to institutions"
      end
    end

    Study.joins("INNER JOIN facilities on facilities.nct_id = studies.nct_id INNER JOIN facility_investigators on facility_investigators.facility_id = facilities.id").where(WHERE, FACILITYWHERE).select("facility_investigators.name as facility_investigators_name, facility_investigators.nct_id as facility_investigators_nct_id, facility_investigators.facility_id as facility_investigators_facility_id, facility_investigators.id as facility_investigators_id").each do |finvestigator|
      if institution = Institution.find_by(facility_id: finvestigator.facility_investigators_facility_id)
        doctor = Doctor.find_or_initialize_by(name: finvestigator.facility_investigators_name, investigatorid: finvestigator.facility_investigators_id)
        doctor.facility_id = finvestigator.facility_investigators_facility_id
        doctor_nct_id = finvestigator.facility_investigators_nct_id
        doctor.save!
        institution.doctors << doctor unless institution.doctors.include?(doctor)
        trial = Trial.find_by(trial_nct_id: finvestigator.facility_investigators_nct_id)
        trial.doctors << doctor unless trial.doctors.include?(doctor)
        puts "Doctor saved and added to institution"
      end
    end
  end
end

######################### PREVIOUS CODE ############################

# class Syncer
#   JOINS = "
#       INNER JOIN facilities
#         ON facilities.nct_id = studies.nct_id
#       INNER JOIN browse_conditions
#         ON browse_conditions.nct_id = studies.nct_id
#       INNER JOIN eligibilities
#         ON eligibilities.nct_id = studies.nct_id
#       LEFT OUTER JOIN design_groups
#         ON design_groups.nct_id = studies.nct_id
#       LEFT OUTER JOIN central_contacts
#         ON central_contacts.nct_id = studies.nct_id
#       LEFT OUTER JOIN facility_investigators
#         ON facility_investigators.facility_id = facilities.id
#       LEFT OUTER JOIN facility_contacts
#         ON facility_contacts.facility_id = facilities.id"

#   WHERE = "
#     facilities.country = 'Brazil' AND
#     overall_status = 'Recruiting' AND
#     facilities.status = 'Recruiting' AND
#     study_type = 'Interventional'"

#   SELECT = "
#     studies.nct_id as study_nct_id,
#     browse_conditions.mesh_term as condition_name,
#     studies.brief_title as brief_title,
#     eligibilities.gender as gender,
#     eligibilities.maximum_age as maximum_age,
#     eligibilities.minimum_age as minimum_age,
#     facilities.name as facility_name,
#     facilities.nct_id as institution_nct_id,
#     facilities.city as facility_city,
#     facilities.state as facility_state,
#     facilities.country as facility_country,
#     facilities.zip as facility_zip,
#     central_contacts.name as central_contact_name,
#     central_contacts.email as central_contact_email,
#     central_contacts.phone as central_contact_phone,
#     facility_investigators.name as facility_investigators_name,
#     facility_investigators.role as facility_investigators_role,
#     facility_investigators.id as facility_investigators_id,
#     facility_contacts.name as facility_contacts_name,
#     facility_contacts.email as facility_contacts_email,
#     facility_contacts.phone as facility_contacts_phone,
#     facilities.id as facility_id,
#     design_groups.description as brief_description"

#   def sync
#     puts "Beginning sync..."

#     Study.joins(JOINS).where(WHERE).select(SELECT).each do |f|
#       trial = save_trial(f)
#       puts "Trial #{trial.id} saved"

#       institution = save_institution(f)
#       puts "Institution #{institution.id} saved"

#       doctor = save_doctor(f)
#       puts "Doctor #{doctor.id} saved"

#       trial.doctors << doctor unless trial.doctors.include?(doctor)
#       puts "Connected doctor to trial"

#       trial.institutions << institution unless trial.institutions.include?(institution)
#       puts "Connected institution to trial"
#       trial.save

#       institution.doctors << doctor unless institution.doctors.include?(doctor)
#       puts "Connected doctor to institution"

#       institution.save
#     end
#   end

#   def save_trial(f)
#     #Only create trial if the NCT_ID is not present
#     trial = Trial.find_or_initialize_by(trial_nct_id: f.study_nct_id)
#     #A trial can treat many conditions. Add a condition if the nct_id is present but the condition is different.
#     if trial.persisted?
#       unless trial.condition.include?(f.condition_name)
#         trial.condition << f.condition_name
#         trial.save
#       end
#       #A trial can also have many central contacts. Do the same thing that happens with condition here
#       unless trial.centralcontacts.include?({'name' => f.central_contact_name, 'email' => f.central_contact_email, 'phone' => f.central_contact_phone})
#         trial.centralcontacts << {'name' => f.central_contact_name, 'email' => f.central_contact_email, 'phone' => f.central_contact_phone}
#         trial.save
#       end
#       #Create a trial with these params if there isn't one in the database
#     else
#       trial.title = f.brief_title
#       trial.description = f.brief_description
#       trial.eligibility = [f.gender, f.minimum_age, f.maximum_age].join(", ")
#       trial.condition = [f.condition_name]
#       trial.centralcontacts = [{name: f.central_contact_name, email: f.central_contact_email, phone: f.central_contact_email}]
#       trial.save
#     end

#     trial
#   end

#   def save_institution(f)
#     # Only create an Institution if there isn't one with the name and institution_id present already.
#     institution = Institution.find_or_initialize_by(facility_id: f.facility_id)
#     institution.name = f.facility_name

#     if institution.persisted?
#       update_institution(institution, f)
#     else
#       create_institution(institution, f)
#     end

#     institution.save
#     institution
#   end

#   def save_doctor(f)
#     doctor = Doctor.find_or_create_by(investigatorid: f.facility_investigators_id, name: f.facility_investigators_name)
#     doctor
#   end

#   def update_institution(institution, f)
#     #An institution can have many contacts. Insert the new one if it's not present

#     contact = build_facility_contact(f)
#     unless institution.institutioncontacts.include?(contact)
#       institution.institutioncontacts << contact
#     end
#   end

#   def create_institution(institution, f)
#     institution.institution_nct_id = f.institution_nct_id
#     institution.facility_id = f.facility_id
#     institution.institutioncontacts = [build_facility_contact(f)]
#     institution.address = [f.facility_name, f.facility_city, f.facility_state, f.facility_country, f.facility_zip].join(", ")
#   end

#   def build_facility_contact(f)
#     {
#       'name' => f.facility_contacts_name,
#       'email' => f.facility_contacts_email,
#       'phone' => f.facility_contacts_phone
#     }
#   end
# end

