class AddReturningPatientToIntakes < ActiveRecord::Migration[8.1]
  def change
    add_column :intakes, :returning_patient, :boolean
  end
end
