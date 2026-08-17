require "rails_helper"

RSpec.describe Patient, type: :model do
  it "normalizes email addresses before saving" do
    patient = create(
      :patient,
      email: "  TEST.patient@Example.COM  "
    )

    expect(patient.email).to eq("test.patient@example.com")
  end

  it "is invalid without a date of birth" do
    patient = build(:patient, date_of_birth: nil)

    expect(patient).not_to be_valid
    expect(patient.errors[:date_of_birth]).to include("can't be blank")
  end

  it "normalizes an email address when updating a patient" do
    patient = create(
      :patient,
      email: "test.patient@example.com"
    )

    patient.update!(email: "  Test.Patient@New.COM  ")

    expect(patient.email).to eq("test.patient@new.com")
  end
end
