class InstitutionsController < ApplicationController
  def index
  end

  def show
    @institution = Institution.find(params[:id])
    @trial = Trial.find(1)
    @trial.doctor = Doctor.find(1)
  end
end
