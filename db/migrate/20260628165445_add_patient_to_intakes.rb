class AddPatientToIntakes < ActiveRecord::Migration[8.1]
  def change
    add_reference :intakes, :patient, null: true, foreign_key: true
  end
end
