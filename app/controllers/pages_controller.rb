class PagesController < ApplicationController
  # Added to skip authentication on home/root page
  skip_before_action :authenticate_user!, only: :home

  def home
  end
end
