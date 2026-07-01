class MakePatientIdRequiredOnIntakes < ActiveRecord::Migration[8.1]
  def change
    change_column_null :intakes, :patient_id, false
  end
end