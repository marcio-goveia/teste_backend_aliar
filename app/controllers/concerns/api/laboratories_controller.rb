class Api::LaboratoriesController < ApplicationController
  before_action :set_laboratory, only: %i[show update]

  # GET /laboratories
  def index
    @laboratories = Laboratory.all

    render json: @laboratories
  end

  # GET /laboratories/1
  def show
    render json: @laboratory
  end

  # POST /laboratories
  def create
    @laboratory = Laboratory.new(laboratory_params)

    if @laboratory.save
      render json: @laboratory, status: :created
    else
      render json: @laboratory.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /laboratories/1
  def update
    if @laboratory.update(laboratory_params)
      render json: @laboratory
    else
      render json: @laboratory.errors, status: :unprocessable_entity
    end
  end

  def disable
    laboratory = Laboratory.find(params[:laboratory_id])
    laboratory.disable!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_laboratory
    @laboratory = Laboratory.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def laboratory_params
    params.require(:laboratory).permit(:name, :address)
  end
end
