class TypesController < ApplicationController
  def index
  end

  def show
    @type = Type.find(params[:id])
  end
end
