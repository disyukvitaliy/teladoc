module API
  class AppointmentsController < ApplicationController
    def index
      render json: {
        appointments: AppointmentsQuery.new(params).call.order(:time).as_json(include: :specialist, only: [:id, :time], methods: :available)
      }
    end

    # NOTE: for purpose of editing appointments by admins, for example
    def update
      ActiveRecord::Base.transaction do
        appointment = Appointment.lock.find(params[:id])

        if appointment.update(permitted_attributes)
          render json: { appointment: appointment.as_json(only: [], methods: :available) }
        else
          render json: { errors: appointment.errors }
        end
      end
    end

    # NOTE: for purpose of deleting appointments by admins, for example
    def delete
      ActiveRecord::Base.transaction do
        appointment = Appointment.available.lock.find(params[:id])
        if appointment.destroy
          head :no_content
        else
          render json: { errors: appointment.errors }
        end
      end
    end

    private

    def permitted_attributes
      params.require(:appointment).permit(:patient_id)
    end
  end
end
