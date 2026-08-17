class AddDateOfBirthToIntakes < ActiveRecord::Migration[8.1]
  def change
    add_column :intakes, :date_of_birth, :date
  end
end
