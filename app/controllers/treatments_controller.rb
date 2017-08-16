class TreatmentsController < ApplicationController
  def index
    # Added to find locations where the medical condition informed on the search bar is treated
    @trials = Trial.find_by(condition: params[:condition]).institutions
    # Added for geocoding. MUST CHANGE @treatments to receive Treatment.where.not instead
    @treatments = @trials.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@treatments) do |treatment, marker|
      marker.lat treatment.latitude
      marker.lng treatment.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def show
    # Added for geocoding. MUST CHANGE @treatment to receive Treatment.find instead
    @treatment = Institution.find(params[:id])
    # From this line on it should keep running after above-mentioned changes
    @treatment_coordinates = { lat: @treatment.latitude, lng: @treatment.longitude }
    # @alert_message = "You are viewing the Institution: #{@treatment.name}"
  end

end
