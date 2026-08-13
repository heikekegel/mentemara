class CreateContactMethods < ActiveRecord::Migration[8.1]
  def change
    create_table :contact_methods do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :kind, null: false
      t.string :value, null: false
      t.date :effective_from, null: false
      t.date :effective_to

      t.timestamps
    end

    add_index :contact_methods,
              [ :patient_id, :kind ],
              unique: true,
              where: "effective_to IS NULL",
              name: "index_current_contact_methods_on_patient_and_kind"
  end
end
