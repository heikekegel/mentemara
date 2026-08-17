class MakeDateOfBirthNotNull < ActiveRecord::Migration[8.1]
  def change
    change_column_null :patients, :date_of_birth, false
    change_column_null :intakes, :date_of_birth, false
  end
end
