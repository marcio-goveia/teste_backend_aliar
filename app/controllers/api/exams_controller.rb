class Api::ExamsController < ApplicationController
  before_action :set_exam, only: %i[show update]

  # GET /exams
  def index
    @exams = Exam.all

    render json: @exams
  end

  # GET /exams/1
  def show
    render json: @exam
  end

  # POST /exams
  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      render json: @exam, status: :created
    else
      render json: @exam.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exams/1
  def update
    if @exam.update(exam_params)
      render json: @exam
    else
      render json: @exam.errors, status: :unprocessable_entity
    end
  end

  # DELETE /exams/1
  def disable
    exam = Exam.find(params[:exam_id])
    exam.disable!
  end

  def batch_create
    begin
      Exam.transaction do
        Exam.create!(exams_params)
        render json: nil, status: :created
      end
    rescue ActiveRecord::RecordInvalid => e
      exams = { error: { status: 422, message: e } }
      render json: exams.error, status: :unprocessable_entity
    end
  end

  def batch_update
    begin
      Exam.transaction do
        exams_hash = {}
        exams_params.each do |e| 
          exams_hash[e[:id]] = e.except(:id).to_h
        end
        Exam.update(exams_hash.keys, exams_hash.values)
        render json: nil
      end
    rescue ActiveRecord::RecordInvalid => e
      exams = { error: { status: 422, message: e } }
      render json: exams.error, status: :unprocessable_entity
    end
  end

  def batch_disable
    begin
      Exam.transaction do
        Exam.where('id in (?)', exams_ids_params).update_all(status: false)
        render json: nil
      end
    rescue ActiveRecord::RecordInvalid => e
      exams = { error: { status: 422, message: e } }
      render json: exams.error, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exam
    @exam = Exam.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def exam_params
    params.require(:exam).permit(:name, :kind)
  end

  def exams_params
    params.permit(exams: %i[id name kind]).require(:exams)
  end

  def exams_ids_params
    params.require(:ids)
  end
end
