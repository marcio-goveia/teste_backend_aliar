class ExamLaboratory < ApplicationRecord
  self.table_name = 'exams_laboratories'

  belongs_to :laboratory
  belongs_to :exam

end
