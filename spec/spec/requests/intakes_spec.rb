require "rails_helper"

RSpec.describe "Intakes", type: :request do
  let(:valid_attributes) do
    {
      full_name: "Test User",
      email: "test@example.com",
      phone: "2162019511",
      reason_for_visit: "Anxiety",
      urgency: "Routine"
    }
  end

  describe "GET /intakes" do
    it "returns a successful response" do
      get intakes_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /intakes" do
    it "creates a new intake" do
      expect {
        post intakes_path, params: { intake: valid_attributes }
      }.to change(Intake, :count).by(1)
    end

    it "redirects to the created intake" do
      post intakes_path, params: { intake: valid_attributes }

      expect(response).to redirect_to(intake_path(Intake.last))
    end
  end

  describe "DELETE /intakes/:id" do
    it "deletes an intake" do
      intake = Intake.create!(valid_attributes)

      expect {
        delete intake_path(intake), headers: { "ACCEPT" => "application/json" }
      }.to change(Intake, :count).by(-1)
    end

    it "returns a successful JSON response" do
      intake = Intake.create!(valid_attributes)

      delete intake_path(intake), headers: { "ACCEPT" => "application/json" }

      expect(response).to have_http_status(:ok)
    end
  end
end
