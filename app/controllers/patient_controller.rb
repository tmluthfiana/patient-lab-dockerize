class PatientController < ApplicationController
  def index
  	patient = Patient.all

  	render json: patient
  end

  def show
  	patient = Patient.find(params[:id])
  	patient_lab = PatientLab.where(patient_id: params[:id])

  	patient_json = patient.as_json
  	patient_json[:lab_studies] = patient_lab.as_json
  	
  	render json: patient_json
  end

  def create
  	@patient = Patient.new(patient_attributes(patient_params))
    
    if @patient.save
      patient_params[:lab_studies].each do |lab_params|
      	patient_lab = PatientLab.new(lab_attribute(@patient, lab_params))
      	patient_lab.save
      end

      patient_lab = PatientLab.where(patient_id: @patient[:id])
	  patient_json = @patient.as_json
	  patient_json[:lab_studies] = patient_lab.as_json
	  render json: patient_json
    else

      render json: { error_message: "Failed Save Data"}
    end
  end

  def destroy
  	patient = Patient.find(params[:id])
  	patient_lab = PatientLab.where(patient_id: params[:id])

  	if patient_lab.present?
  	  patient_lab.each do |lab|
  	  	lab.destroy
  	  end
  	end

  	patient.destroy
  	render json: { success: "Data Deleted"}
  end

  private
    def patient_params
      params.permit!
    end

    def patient_attributes(patient_params)
      if patient_params[:patient_data]
      	patient_data = patient_params[:patient_data]
        {
          patient_name: [patient_data[:first_name], patient_data[:last_name]].select(&:present?).join(' ').titleize,
          id_number: patient_data[:id_number],
          phone_mobile: patient_data[:phone_mobile],
          gender: patient_data[:gender],
          date_of_birth: patient_data[:date_of_birth],
          date_of_test: patient_params[:date_of_test],
          lab_number: patient_params[:lab_number],
          clinic_code: patient_params[:clinic_code]
        }
      else
      	{
          patient_name: patient_params[:patient_name],
          id_number: patient_params[:id_number],
          phone_mobile: patient_params[:phone_mobile],
          gender: patient_params[:gender],
          date_of_birth: patient_params[:date_of_birth],
          date_of_test: patient_params[:date_of_test],
          lab_number: patient_params[:lab_number],
          clinic_code: patient_params[:clinic_code]
        }
      end
    end

    def lab_attribute(patient, lab_params)
      {
      	patient_id: patient.id,
        code: lab_params[:code],
        name: lab_params[:name],
        value: lab_params[:value],
        unit: lab_params[:unit],
        ref_range: lab_params[:ref_range],
        finding: lab_params[:finding],
        result_state: lab_params[:result_state]
      }
    end
end
