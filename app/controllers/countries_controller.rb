class CountriesController < ApplicationController
  def index
    @countries = Country.all.page(params[:page])
  end

  def show
    @country = Country.find(params[:id])
  end
end
