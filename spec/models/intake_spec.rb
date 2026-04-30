require "rails_helper"

RSpec.describe Intake, type: :model do
  let(:valid_attributes) do
    {
      full_name: "Test User",
      email: "test@example.com",
      phone: "2162019511",
      reason_for_visit: "Anxiety",
      urgency: "Routine"
    }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      intake = Intake.new(valid_attributes)
      expect(intake).to be_valid
    end

    it "is invalid without a full name" do
      intake = Intake.new(valid_attributes.merge(full_name: nil))

      expect(intake).not_to be_valid
      expect(intake.errors[:full_name]).to include("can't be blank")
    end

    it "is invalid without an email" do
      intake = Intake.new(valid_attributes.merge(email: nil))

      expect(intake).not_to be_valid
      expect(intake.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a reason for visit" do
      intake = Intake.new(valid_attributes.merge(reason_for_visit: nil))

      expect(intake).not_to be_valid
      expect(intake.errors[:reason_for_visit]).to include("can't be blank")
    end

    it "is invalid without urgency" do
      intake = Intake.new(valid_attributes.merge(urgency: nil))

      expect(intake).not_to be_valid
      expect(intake.errors[:urgency]).to include("can't be blank")
    end

    it "is valid without an insurance provider" do
      intake = Intake.new(valid_attributes.merge(insurance_provider: nil))

      expect(intake).to be_valid
    end

    it "is invalid with a non-numeric phone number" do
      intake = Intake.new(valid_attributes.merge(phone: "abc1236789"))

      expect(intake).not_to be_valid
      expect(intake.errors[:phone]).to include("must be a valid phone number")
    end

    it "is invalid with a phone number that is too short" do
      intake = Intake.new(valid_attributes.merge(phone: "123"))

      expect(intake).not_to be_valid
      expect(intake.errors[:phone]).to include("must be a valid phone number")
    end

    it "is valid with a 15-digit phone number" do
      intake = Intake.new(valid_attributes.merge(phone: "123456789012345"))

      expect(intake).to be_valid
    end
  end
end
