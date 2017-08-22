class InstitutionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @condition = params[:condition]

    # review line to fix search by distance from user_location
    @institutions = Institution.joins(:trials).where('trials.condition @@ ?', "#{@condition}").where.not(latitude: nil, longitude: nil).distinct

    # .page(params[:page])

    @hash = Gmaps4rails.build_markers(@institutions) do |institution, marker|
      marker.lat institution.latitude
      marker.lng institution.longitude
    end
  end

  def show
    @institution = Institution.find(params[:id])
    @condition = params[:condition]
    @trials = @institution.trials.where('condition @@ ?', "#{@condition}")
  end

  private

  def user_location
    return request.location unless Rails.env.development?
    Struct.new(:latitude, :longitude).new(23.5611818, -46.6892361)
  end
end
