class TreatmentsController < ApplicationController

  def create
    @treatment = Treatment.new(treatment_params)
    @treatment.save!
  end


  def index
    #MOVED TO INSTITUTION CONTROLLER By DocBotelho
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
