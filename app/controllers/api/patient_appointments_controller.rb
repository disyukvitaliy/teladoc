module API
  class PatientAppointmentsController < ApplicationController
    def index
      render json: {
        appointments: current_user.appointments.order(time: :desc).as_json(include: :specialist, only: [:id, :time])
      }
    end

    def create
      ActiveRecord::Base.transaction do
        appointment = Appointment.available.lock.find(params[:appointment][:id])

        if appointment.update(patient: current_user)
          render json: { appointment: appointment.as_json(include: :specialist, only: [:id, :time]) }
        else
          render json: { errors: appointment.errors }
        end
      end
    end

    def destroy
      appointment = current_user.appointments.find(params[:id])

      if appointment.update(patient_id: nil)
        head :no_content
      else
        render json: { errors: appointment.errors }
      end
    end

    private

    # TODO: Add devise
    def current_user
      Patient.find_by(name: 'Patient #1')
    end
  end
end
