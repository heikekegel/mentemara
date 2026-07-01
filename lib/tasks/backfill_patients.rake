namespace :patients do
  desc "Backfill patients for existing intakes"
  task backfill_from_intakes: :environment do
    intakes = Intake.where(patient_id: nil)

    puts "Found #{intakes.count} intakes without patients"

    intakes.find_each do |intake|
      patient = Patient.find_or_initialize_by(email: intake.email)

      patient.full_name = intake.full_name
      patient.phone_number = intake.phone.to_s.gsub(/\D/, "")

      patient.save!

      intake.update_column(:patient_id, patient.id)

      puts "Linked Intake ##{intake.id} to Patient ##{patient.id} (#{patient.full_name})"
    end

    puts "Done. Remaining intakes without patients: #{Intake.where(patient_id: nil).count}"
  end
end