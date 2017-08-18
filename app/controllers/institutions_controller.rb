class InstitutionsController < ApplicationController
  def index
    # Added to find locations where the medical condition informed on the search bar is treated
    @condition = []
    upcase_words
    @trials = Trial.where(condition: @condition)
    if @trials.nil?
      @institutions = []
    else
      @trials.each do |trial|
        @institutions = trial.institutions
        # Added for geocoding. MUST CHANGE @treatments to receive Treatment.where.not instead
        @institutions = @institutions.where.not(latitude: nil, longitude: nil).page(params[:page])
      end
    end

    @hash = Gmaps4rails.build_markers(@institutions) do |institution, marker|
      marker.lat institution.latitude
      marker.lng institution.longitude
    end
  end

  def show
    @institution = Institution.find(params[:id])
    @trial = @institution.trials.first
  end

private

  def upcase_words
    params[:condition].downcase.split.each do |word|
      @condition << word.capitalize
    end
    @condition = @condition.join(" ")
  end

end
