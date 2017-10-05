class InstitutionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # add user_location to narrow search
    location = [user_location.latitude, user_location.longitude]
    # added var range to limit/filter search by distance
    range = 10000

    #add search on table disease to find trial.condition when given a disease in Portuguese
    @condition = user_condition(params[:condition])

    @institutions = Institution.near(location, range).condition_search(@condition).where.not(latitude: nil, longitude: nil)
    @institutions_paginate = @institutions.page(params[:page])
    @hash = Gmaps4rails.build_markers(@institutions) do |institution, marker|
      marker.lat institution.latitude
      marker.lng institution.longitude
      marker.infowindow render_to_string(partial: "/institutions/inst_card", locals: {institution: institution, condition: @condition})
      marker.picture({
        url: "http://i.imgur.com/F0UMxsX.png",
        :width => 96,
        :height => 96,
        })
    end
  end

  def show
    @institution = Institution.find(params[:id])
    @condition = user_condition(params[:condition])
    @trials = @institution.trials.search_by_condition(@condition)
    @treatment = Treatment.new
    @treatment.institution = @institution
  end

  private

  def user_condition(disease)
    @user_condition = disease.downcase
    disease = Disease.find_by(portuguese: @user_condition)

    if disease.nil?
      @condition = ""
    else
      @condition = disease.english
    end
  end

  def user_location
    return request.location unless Rails.env.development?
    Struct.new(:latitude, :longitude).new(-23.5711274, -46.652232)
  end
end
