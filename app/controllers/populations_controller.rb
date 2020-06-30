class PopulationsController < ApplicationController
  before_action do
    redirect_to populations_path, alert: "Year must be less than: #{Population::MAX_FUTURE_YEAR}" if params[:year].to_i > Population::MAX_FUTURE_YEAR
  end

  def index
  end

  def show
    @year = params[:year].to_i
    @population = Population.get(@year)
  end
end
