class Safesyncer
  JOINS = "INNER JOIN facilities on facilities.nct_id = studies.nct_id"

  WHERE = "
     facilities.country = 'Brazil' AND
     overall_status = 'Recruiting' AND
     study_type = 'Interventional'"

  FACILITYWHERE = "
    facilities.status = 'Recruiting'"

  SELECT = "DISTINCT ON (studies.nct_id) *"
  def sync
    puts "Beginning safesyncer..."

    Study.joins("INNER JOIN detailed_descriptions ON detailed_descriptions.nct_id = studies.nct_id INNER JOIN facilities ON facilities.nct_id = studies.nct_id").where(WHERE).select("detailed_descriptions.description as description, detailed_descriptions.nct_id as description_nct_id").each do |desc|
      Trial.where(trial_nct_id: desc.description_nct_id).update(description: desc.description)
          # trial = Trial.find_by(trial_nct_id: desc.description_nct_id)
          #   trial.description = desc.description
          #   trial.save!
      puts "Added description to trial"
    end

    Study.joins("INNER JOIN facilities on facilities.nct_id = studies.nct_id INNER JOIN brief_summaries on brief_summaries.nct_id = studies.nct_id").where(WHERE).select("brief_summaries.nct_id as brief_summaries_nct_id, brief_summaries.description as brief_summaries_description").each do |desc|
      Trial.where(trial_nct_id: desc.brief_summaries_nct_id, description: nil).update(description: desc.brief_summaries_description)
      puts "Added description to nil"
    end

    Study.joins("INNER JOIN facilities ON facilities.nct_id = studies.nct_id INNER JOIN links ON links.nct_id = studies.nct_id").where(WHERE).select("links.nct_id as links_nct_id, links.url as url").each do |url|
      Trial.where(trial_nct_id: url.links_nct_id).update(link: url.url)
      puts "Added link to link"
    end
  end
end
