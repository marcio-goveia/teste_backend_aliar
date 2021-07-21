class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :name, null: false
      t.integer :kind, null: false
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
