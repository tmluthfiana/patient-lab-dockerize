class CreatePatientLabs < ActiveRecord::Migration[6.0]
  def change
    create_table :patient_labs do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :name
      t.string :code
      t.string :value
      t.string :unit
      t.string :ref_range
      t.string :finding
      t.string :result_state

      t.timestamps
    end
  end
end
