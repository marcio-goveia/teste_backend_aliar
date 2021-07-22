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

  def batch_create
    begin
      Laboratory.transaction do
        Laboratory.create!(laboratories_params)
        render json: nil, status: :created
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: e, status: :unprocessable_entity
    end
  end

  def batch_update
    begin
      Laboratory.transaction do
        laboratories_hash = {}
        laboratories_params.each do |l|
          laboratories_hash[l[:id]] = l.except(:id).to_h
        end
        Laboratory.update(laboratories_hash.keys, laboratories_hash.values)
        render json: nil
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: e, status: :unprocessable_entity
    end
  end

  def batch_disable
    begin
      Laboratory.transaction do
        Laboratory.where('id in (?)', laboratories_ids_params).update_all(status: false)
        render json: nil
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: e, status: :unprocessable_entity
    end
  end

  def search_by_exam
    exam_name = params[:exam_name]
    @laboratories = Laboratory.joins(:exams).where('trim(exams.name) like ?', "%#{exam_name.strip.downcase}%")
    render json: @laboratories
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

  def laboratories_params
    params.permit(laboratories: %i[id name address]).require(:laboratories)
  end

  def laboratories_ids_params
    params.require(:ids)
  end
end
