require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "normalizes email addresses before saving" do
    patient = Patient.create!(
      full_name: "Heike Kegel",
      email: "  Heike.Kegel@Example.COM  ",
      phone_number: "555-1234"
    )

    expect(patient.email).to eq("heike.kegel@example.com")
  end

  it "normalizes an email address when updating a patient" do
    patient = Patient.create!(
      full_name: "Heike Kegel",
      email: "heike.kegel@example.com",
      phone_number: "555-1234"
    )

    patient.update!(
      email: "  Heike.Kegel@New.COM  "
    )

    expect(patient.email).to eq("heike.kegel@new.com")
  end
end
