class InstitutionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # add user_location to narrow search

    @condition = params[:condition]
    location = [user_location.latitude, user_location.longitude]

    # added var range to limit/filter search by distance
    range = 10

    @institutions = Institution.near(location, range).condition_search(@condition).where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@institutions) do |institution, marker|
      marker.lat institution.latitude
      marker.lng institution.longitude
    end
  end

  def show
    @institution = Institution.find(params[:id])
    @condition = params[:condition]
    @trials = @institution.trials.search_by_condition(@condition)
  end

  private

  def user_location
    return request.location unless Rails.env.development?
    Struct.new(:latitude, :longitude).new(-23.5611818, -46.6892361)
  end
end
