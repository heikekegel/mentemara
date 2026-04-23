class CreateIntakes < ActiveRecord::Migration[8.1]
  def change
    create_table :intakes do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.text :reason_for_visit
      t.string :urgency
      t.string :insurance_provider

      t.timestamps
    end
  end
end
