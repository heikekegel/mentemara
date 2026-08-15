require "json"

patients_path = "/tmp/mentemara_sqlite_patients.json"
intakes_path = "/tmp/mentemara_sqlite_intakes.json"

patients = JSON.parse(File.read(patients_path))
intakes = JSON.parse(File.read(intakes_path))

puts "Loaded #{patients.size} patients"
puts "Loaded #{intakes.size} intakes"

patients_by_old_id = {}

# Phase 1: find or create all patients and remember them by their old SQLite ID
patients.each do |patient_data|
  old_id = patient_data["id"]

  patient =
    if old_id == 2
      # SQLite patient 2 is the existing PostgreSQL Heike record.
      Patient.find(1)
    else
      normalized_email = patient_data["email"].to_s.strip.downcase

      Patient.find_or_create_by!(email: normalized_email) do |new_patient|
        new_patient.full_name = patient_data["full_name"]
        new_patient.phone_number = patient_data["phone_number"]
        new_patient.created_at = patient_data["created_at"]
        new_patient.updated_at = patient_data["updated_at"]
      end
    end

  patients_by_old_id[old_id] = patient

  puts "Mapped SQLite patient #{old_id} to PostgreSQL patient #{patient.id}"
end

# Phase 2: import intakes using the completed old-ID -> Patient lookup hash
intakes.each do |intake_data|
  old_patient_id = intake_data["patient_id"]
  patient = patients_by_old_id[old_patient_id]

  raise "No mapped patient for old patient ID #{old_patient_id}" unless patient

  existing_intake = Intake.find_by(
    patient: patient,
    created_at: intake_data["created_at"]
  )

  if existing_intake
    puts "Skipping SQLite intake #{intake_data["id"]}: already imported"
  else
    intake = Intake.create!(
      patient: patient,
      full_name: intake_data["full_name"],
      email: intake_data["email"],
      phone: intake_data["phone"],
      reason_for_visit: intake_data["reason_for_visit"],
      urgency: intake_data["urgency"],
      insurance_provider: intake_data["insurance_provider"],
      created_at: intake_data["created_at"],
      updated_at: intake_data["updated_at"]
    )

    puts "Imported SQLite intake #{intake_data["id"]} as PostgreSQL intake #{intake.id}"
  end
end
