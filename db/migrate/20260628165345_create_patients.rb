class CreatePatients < ActiveRecord::Migration[8.1]
  def change
    create_table :patients do |t|
      t.string :full_name
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
