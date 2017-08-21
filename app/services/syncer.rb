class Syncer
  JOINS = "
      INNER JOIN facilities
        ON facilities.nct_id = studies.nct_id
      INNER JOIN browse_conditions
        ON browse_conditions.nct_id = studies.nct_id
      INNER JOIN eligibilities
        ON eligibilities.nct_id = studies.nct_id
      INNER JOIN design_groups
        ON design_groups.nct_id = studies.nct_id
      INNER JOIN central_contacts
        ON central_contacts.nct_id = studies.nct_id
      INNER JOIN facility_investigators
        ON facility_investigators.facility_id = facilities.id
      INNER JOIN facility_contacts
        ON facility_contacts.facility_id = facilities.id"

  WHERE = "
    facilities.country = 'Brazil' AND
    facilities.status = 'Recruiting' AND
    study_type = 'Interventional'"

  SELECT = "
    studies.nct_id as study_nct_id,
    browse_conditions.mesh_term as condition_name,
    studies.brief_title as brief_title,
    eligibilities.gender as gender,
    eligibilities.maximum_age as maximum_age,
    eligibilities.minimum_age as minimum_age,
    facilities.name as facility_name,
    facilities.nct_id as institution_nct_id,
    facilities.city as facility_city,
    facilities.state as facility_state,
    facilities.country as facility_country,
    facilities.zip as facility_zip,
    central_contacts.name as central_contact_name,
    central_contacts.email as central_contact_email,
    central_contacts.phone as central_contact_phone,
    facility_investigators.name as facility_investigators_name,
    facility_investigators.role as facility_investigators_role,
    facility_investigators.id as facility_investigators_id,
    facility_contacts.name as facility_contacts_name,
    facility_contacts.email as facility_contacts_email,
    facility_contacts.phone as facility_contacts_phone,
    facilities.id as facility_id,
    design_groups.description as brief_description"

  def sync
    puts "Beginning sync..."

    Study.joins(JOINS).where(WHERE).select(SELECT).each do |f|
      trial = save_trial(f)
      puts "Trial #{trial.id} saved"

      institution = save_institution(f)
      puts "Institution #{institution.id} saved"

      doctor = save_doctor(f)
      puts "Doctor #{doctor.id} saved"

      trial.doctors << doctor unless trial.doctors.include?(doctor)
      puts "Connected doctor to trial"

      trial.institutions << institution unless trial.institutions.include?(institution)
      puts "Connected institution to trial"
      trial.save

      institution.doctors << doctor unless institution.doctors.include?(doctor)
      puts "Connected doctor to institution"

      institution.save
    end
  end

  def save_trial(f)
    #Only create trial if the NCT_ID is not present
    trial = Trial.find_or_initialize_by(trial_nct_id: f.study_nct_id)
    #A trial can treat many conditions. Add a condition if the nct_id is present but the condition is different.
    if trial.persisted?
      if trial.condition != f.condition_name
        trial.condition += ", " + f.condition_name
        trial.save
      end
      #A trial can also have many central contacts. Do the same thing that happens with condition here
      unless trial.centralcontacts.include?({name: f.central_contact_name, email: f.central_contact_email, phone: f.central_contact_phone})
        trial.centralcontacts << {name: f.central_contact_name, email: f.central_contact_email, phone: f.central_contact_phone}
        trial.save
      end
      #Create a trial with these params if there isn't one in the database
    else
      trial.title = f.brief_title
      trial.description = f.brief_description
      trial.eligibility = [f.gender, f.minimum_age, f.maximum_age].join(", ")
      trial.condition = f.condition_name
      trial.centralcontacts = [{name: f.central_contact_name, email: f.central_contact_email, phone: f.central_contact_email}]
      trial.save
    end

    trial
  end

  def save_institution(f)
    # Only create an Institution if there isn't one with the name and institution_id present already.
    institution = Institution.find_or_initialize_by(facility_id: f.facility_id)
    institution.name = f.facility_name

    if institution.persisted?
      update_institution(institution, f)
    else
      create_institution(institution, f)
    end

    institution.save
    institution
  end

  def save_doctor(f)
    doctor = Doctor.find_or_initialize_by(investigatorid: f.facility_investigators_id)
    doctor.name = f.facility_investigators_name
    doctor.save
    doctor
  end

  def update_institution(institution, f)
    #An institution can have many contacts. Insert the new one if it's not present

    contact = build_facility_contact(f)
    unless institution.institutioncontacts.include?(contact)
      institution.institutioncontacts << contact
    end
  end

  def create_institution(institution, f)
    institution.facility_id = f.facility_id
    institution.institutioncontacts = [build_facility_contact(f)]
    institution.address = [f.facility_name, f.facility_city, f.facility_state, f.facility_country, f.facility_zip].join(", ")
  end

  def build_facility_contact(f)
    {
      name: f.facility_contacts_name,
      email: f.facility_contacts_email,
      phone: f.facility_contacts_phone
    }
  end
end
