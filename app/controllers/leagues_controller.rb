class LeaguesController < ApplicationController
  def index
    @leagues = League.includes(:country, :type).all
  end

  def show
    @league = League.find(params[:id])
  end
end
