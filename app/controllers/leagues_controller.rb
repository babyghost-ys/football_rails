class LeaguesController < ApplicationController
  def index
    @leagues = League.includes(:country, :type).all.page(params[:page])
  end

  def show
    @league = League.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @leagues = League.where("name LIKE ?", wildcard_search)
  end

end
