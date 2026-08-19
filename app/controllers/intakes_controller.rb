class IntakesController < ApplicationController
  def index
    @intakes = Intake.order(created_at: :desc)
  end

  def new
    @intake = Intake.new
  end

  def create
    attributes = normalized_intake_params

    @patient = Patient.find_or_initialize_by(email: attributes["email"])

    @patient.full_name = attributes["full_name"]
    @patient.phone_number = attributes["phone_number"]
    @patient.date_of_birth = attributes["date_of_birth"]

    if @patient.save
      @intake = @patient.intakes.build(attributes)

      if @intake.save
        redirect_to @intake
      else
        render :new, status: :unprocessable_entity
      end
    else
      @intake = Intake.new(attributes)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @intake = Intake.find(params[:id])
    @intake.destroy

    respond_to do |format|
      format.html { redirect_to intakes_path }
      format.json { render json: { success: true } }
    end
  end

  private

  def intake_params
    params.require(:intake).permit(
      :full_name,
      :email,
      :phone_number,
      :reason_for_visit,
      :urgency,
      :insurance_provider,
      :returning_patient,
      :date_of_birth
    )
  end

  def normalized_intake_params
    attributes = intake_params.to_h

    if attributes["returning_patient"] == "unknown"
      attributes["returning_patient"] = nil
    end

    attributes
  end

end
