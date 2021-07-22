class CreateJoinTableLaboratoriesExams < ActiveRecord::Migration[5.2]
  def change
    create_join_table :laboratories, :exams do |t|
      t.index [:laborotory_id, :exam_id], unique: true
      t.index [:exam_id, :laborotory_id], unique: true
    end
  end
end
