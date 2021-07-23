# class CreateJoinTableLaboratoriesExams < ActiveRecord::Migration[5.2]
#   def change
#     create_join_table :laboratories, :exams do |t|
#       t.index [:laborotory_id, :exam_id], unique: true
#       t.index [:exam_id, :laborotory_id], unique: true
#     end
#   end
# end

class CreateJoinTableLaboratoriesExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams_laboratories do |t|
      t.integer :laboratory_id, null: false
      t.integer :exam_id, null: false
      t.timestamps
    end
    add_index :exams_laboratories, [:laboratory_id, :exam_id], unique: true
    add_index :exams_laboratories, :laboratory_id
  end
end
