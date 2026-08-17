# Synthetic DOBs for development data only.
# These dates are fictional and are used only to backfill local development records.

# Complete the synthetic name for patient 6 and preserve it on the historical intake.
reiner = Patient.find(6)
reiner.update!(full_name: "Reiner Hoffmann")

reiner.intakes.find_each do |intake|
  intake.update!(full_name: "Reiner Hoffmann")
end

synthetic_dobs_by_patient_id = {
  1 => Date.new(1983, 11, 29), # Heike Kegel
  2 => Date.new(1974, 3, 12),  # George Fuller
  3 => Date.new(1958, 7, 21),  # Heinz Kegel
  4 => Date.new(1981, 1, 9),   # David Birmingham
  5 => Date.new(1949, 10, 5),  # Elfie Krueger
  6 => Date.new(1967, 6, 17)   # Reiner Hoffmann
}

synthetic_dobs_by_patient_id.each do |patient_id, date_of_birth|
  patient = Patient.find(patient_id)

  patient.update!(date_of_birth: date_of_birth)

  puts "Updated patient #{patient.id} - #{patient.full_name} with DOB #{date_of_birth}"
end

Intake.find_each do |intake|
  raise "Intake #{intake.id} has no patient" unless intake.patient

  intake.update!(date_of_birth: intake.patient.date_of_birth)

  puts "Updated intake #{intake.id} with DOB #{intake.date_of_birth}"
end
