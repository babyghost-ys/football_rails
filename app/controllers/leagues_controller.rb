class LeaguesController < ApplicationController
  def index
    @leagues = League.includes(:country, :type).all
  end
end
