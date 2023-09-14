module API
  class SchedulesController < ApplicationController
    def index
      schedules = Specialist.find(params[:specialist_id]).schedules

      # TODO: If it is required we can return human readable schedule, however I would let FE decide how to display this
      render json: {
        schedules: schedules.as_json(only: [:week_day, :start_offset, :appointment_duration, :appointments_count])
      }
    end

    def create
      schedule = Specialist.find(params[:specialist_id]).schedules.build(permitted_attributes)

      if schedule.save
        render json: { schedule: schedule.as_json(only: [:id, :week_day, :start_offset, :appointment_duration, :appointments_count]) }
      else
        render json: { errors: schedule.errors }
      end
    end

    def update
      schedule = Schedule.find(params[:id])

      if schedule.update(permitted_attributes)
        render json: { schedule: schedule.as_json(only: [:week_day, :start_offset, :appointment_duration, :appointments_count]) }
      else
        render json: { errors: schedule.errors }
      end
    end

    def destroy
      schedule = Schedule.find(params[:id])

      if schedule.destroy
        head :no_content
      else
        render json: { errors: schedule.errors }
      end
    end

    private

    def permitted_attributes
      params.require(:schedule).permit(:week_day, :start_offset, :appointment_duration, :appointments_count)
    end
  end
end
