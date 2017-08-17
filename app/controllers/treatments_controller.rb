class TreatmentsController < ApplicationController

  def create
    @treatment = Treatment.new(treatment_params)
    @treatment.save!
  end


  def index
    # Added to find locations where the medical condition informed on the search bar is treated
    @condition = params[:condition]
    @trials = Trial.find_by(condition: @condition)
    if @trials.nil?
      # Add message on screen "SORRY, NO TREATMENTS AVAILABLE AT THIS MOMENT TO THE CONDITION YOU SEARCHED"
      @institutions = []
    else
      @institutions = @trials.institutions
      # Added for geocoding. MUST CHANGE @treatments to receive Treatment.where.not instead
      @institutions = @institutions.where.not(latitude: nil, longitude: nil)
    end

    @hash = Gmaps4rails.build_markers(@institutions) do |institution, marker|
      marker.lat institution.latitude
      marker.lng institution.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def show
    # Added for geocoding. MUST CHANGE @treatment to receive Treatment.find instead
    @institution = Institution.find(params[:id])
    # From this line on it should keep running after above-mentioned changes
    @institution_coordinates = { lat: @institution.latitude, lng: @institution.longitude }
  end

  private

  def treatment_params
    params.require(:treatment).permit(:institution_id, :trial_id, :doctor_id, :user_id)
  end

end
