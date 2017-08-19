class TreatmentsController < ApplicationController

  def new
    @treatment = Treatment.new
  end

  def create
    @treatment = Treatment.new(treatment_params)
    @treatment.save!
  end

  def index
    #MOVED TO INSTITUTION CONTROLLER By DocBotelho
  end

  def show

  end

  private

  def treatment_params
    params.require(:treatment).permit(:institution_id, :trial_id, :doctor_id, :user_id)
  end

end
