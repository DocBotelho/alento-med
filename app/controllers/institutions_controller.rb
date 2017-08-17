class InstitutionsController < ApplicationController
  def index
    # Added to find locations where the medical condition informed on the search bar is treated
    @condition = []
    params[:condition].downcase.split.each do |word|
      @condition << word.capitalize
    end
    @condition = @condition.join(" ")
    @trials = Trial.find_by(condition: @condition)
    if @trials.nil?
      # Add message on screen "SORRY, NO TREATMENTS AVAILABLE AT THIS MOMENT TO THE CONDITION YOU SEARCHED"
      @institutions = []
    else
      @institutions = @trials.institutions
      # Added for geocoding. MUST CHANGE @treatments to receive Treatment.where.not instead
      @institutions = @institutions.where.not(latitude: nil, longitude: nil).page(params[:page])
    end

    @hash = Gmaps4rails.build_markers(@institutions) do |institution, marker|
      marker.lat institution.latitude
      marker.lng institution.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def show
    # @institution = Institution.find(params[:id])
    @trial = Trial.find(1)
    # @trial.doctor = Doctor.find(1)
  end
end
