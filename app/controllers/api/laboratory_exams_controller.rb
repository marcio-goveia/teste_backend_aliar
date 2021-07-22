class Api::LaboratoryExamsController < ApplicationController
  before_action :set_lab_and_exam

  def associate
    @laboratory.exams << @exam
  end

  def dissociate
    @laboratory.exams.delete(@exam)
  end

  private

  def set_lab_and_exam
    @laboratory = Laboratory.find(params[:laboratory_id])
    @exam = Exam.find(params[:exam_id])
  end

  def lab_and_exam_params
    params.require(:exam).permit(:laboratory_id, :exam_id)
  end
end
