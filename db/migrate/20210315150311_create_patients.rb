class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :patient_name
      t.string :date_of_test
      t.string :lab_number
      t.string :clinic_code
      t.string :id_number
      t.string :gender
      t.string :phone_mobile
      t.string :date_of_birth

      t.timestamps
    end
  end
end
