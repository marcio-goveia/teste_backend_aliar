class CreateLaboratories < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratories do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
