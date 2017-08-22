class InstitutionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  # CONTROLLER ALTERED BY DOCBOTELHO TO FORCE RUNNING BEFORE INSTALLING PGSEARCH GEM

  def index
    @condition = params[:condition]

    # review line to fix search by distance from user_location
    @institutions = Institution.where('address @@ ?', 'São Paulo')

    # commmented line below and replaced by line above to make it run before pgsearch
    # Institution.joins(:trials).where('trials.condition @@ ?', "#{@condition}").where.not(latitude: nil, longitude: nil).distinct
    # .page(params[:page])

    @hash = Gmaps4rails.build_markers(@institutions) do |institution, marker|
      marker.lat institution.latitude
      marker.lng institution.longitude
    end
  end

  def show
    @institution = Institution.find(1)
    # commmented line below and replaced by line above to make it run before pgsearch
    # @institution = Institution.find(params[:id])

    @condition = "diabetes virtual do tipo ZZZ"


    @trials = Trial.where('title @@ ?', 'study')
    # commmented line below and replaced by line above to make it run before pgsearch
    # @trials = @institution.trials.where('condition @@ ?', "#{@condition}")
  end

  private

  def user_location
    return request.location unless Rails.env.development?
    Struct.new(:latitude, :longitude).new(23.5611818, -46.6892361)
  end
end
