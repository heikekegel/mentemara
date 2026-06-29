class IntakesController < ApplicationController
  def index
    @intakes = Intake.order(created_at: :desc)
  end

  def new
    @intake = Intake.new
  end

def create
  @patient = Patient.find_or_initialize_by(email: intake_params[:email])

  @patient.full_name = intake_params[:full_name]
  @patient.phone_number = intake_params[:phone]

  if @patient.save
    @intake = @patient.intakes.build(intake_params)

    if @intake.save
      redirect_to @intake
    else
      render :new, status: :unprocessable_entity
    end
  else
    @intake = Intake.new(intake_params)
    render :new, status: :unprocessable_entity
  end
end

  def show
    @intake = Intake.find(params[:id])
  end

  def edit
    @intake = Intake.find(params[:id])
  end

  def update
    @intake = Intake.find(params[:id])

    if @intake.update(intake_params)
      redirect_to @intake
    else
      render :edit, status: :unprocessable_entity
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
      :phone,
      :reason_for_visit,
      :urgency,
      :insurance_provider
    )
  end
end
