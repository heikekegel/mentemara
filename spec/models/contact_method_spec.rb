require 'rails_helper'

RSpec.describe ContactMethod, type: :model do
  it "is invalid with an unsupported kind" do
    patient = create(:patient)

    contact_method = ContactMethod.new(
      patient: patient,
      kind: "fax",
      value: "555-1234",
      effective_from: Date.current
    )

    expect(contact_method).not_to be_valid
  end

  it "is invalid when effective_to is before effective_from" do
    patient = create(:patient)

    contact_method = ContactMethod.new(
      patient: patient,
      kind: "home_phone",
      value: "555-1234",
      effective_from: Date.new(2026, 8, 20),
      effective_to: Date.new(2026, 8, 10)
    )

    expect(contact_method).not_to be_valid
    expect(contact_method.errors[:effective_to])
      .to include("cannot be before effective from")
  end

  it "is invalid without a value" do
    patient = create(:patient)

    contact_method = ContactMethod.new(
      patient: patient,
      kind: "email",
      effective_from: Date.current
    )

    expect(contact_method).not_to be_valid
    expect(contact_method.errors[:value]).to include("can't be blank")
  end

  it "is invalid without an effective_from date" do
    patient = create(:patient)

    contact_method = ContactMethod.new(
      patient: patient,
      kind: "email",
      value: "test@example.com"
    )

    expect(contact_method).not_to be_valid
    expect(contact_method.errors[:effective_from]).to include("can't be blank")
  end

  it "does not allow two current contact methods of the same kind for one patient" do
    patient = create(:patient)

    ContactMethod.create!(
      patient: patient,
      kind: "email",
      value: "first@example.com",
      effective_from: Date.current
    )

    expect {
      ContactMethod.create!(
        patient: patient,
        kind: "email",
        value: "second@example.com",
        effective_from: Date.current
      )
    }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it "is valid with supported attributes" do
    patient = create(:patient)

    contact_method = ContactMethod.new(
      patient: patient,
      kind: "mobile_phone",
      value: "555-1234",
      effective_from: Date.current
    )

    expect(contact_method).to be_valid
  end
end