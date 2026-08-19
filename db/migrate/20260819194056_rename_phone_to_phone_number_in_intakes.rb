class RenamePhoneToPhoneNumberInIntakes < ActiveRecord::Migration[8.1]
  def change
    rename_column :intakes, :phone, :phone_number
  end
end
