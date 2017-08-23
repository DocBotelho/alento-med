class InstitutionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  # CONTROLLER ALTERED BY DOCBOTELHO TO FORCE RUNNING BEFORE INSTALLING PGSEARCH GEM

  def index
    @condition = params[:condition]

    # commands below used to force var contents and run app before installing pgsearch gem
    # @institutions = Institution.where('address @@ ?', 'São Paulo')
    #original command before installing PG search gem
    # @institutions = Institution.joins(:trials).where('trials.condition @@ ?', "#{@condition}").where.not(latitude: nil, longitude: nil).distinct.page(params[:page])

    @institutions = Institution.condition_search(@condition)

    @hash = Gmaps4rails.build_markers(@institutions) do |institution, marker|
      marker.lat institution.latitude
      marker.lng institution.longitude
    end
  end

  def show
    # commands below used to force var contents and run app before installing pgsearch gem
    # @institution = Institution.find(1)
    # @condition = "diabetes virtual do tipo ZZZ"
    # @trials = Trial.where('title @@ ?', 'study')

    @institution = Institution.find(params[:id])
    @condition = params[:condition]
    @trials = @institution.trials.search_by_condition(@condition)
  end

  private

  def user_location
    return request.location unless Rails.env.development?
    Struct.new(:latitude, :longitude).new(23.5611818, -46.6892361)
  end
end
