##
# This class is responsible for generating appointments from specialist schedules upfront
# For now it is just a dummy class which generates appointments fro the next 7 days
# We can run it periodically using cron or other scheduling solutions
# TODO: Make it smart
class AppointmentScheduler
  def initialize(specialist)
    @specialist = specialist
  end

  def call
    7.times do |i|
      time = (Date.current + i.days).to_time
      week_day = time.strftime('%w').to_i
      schedule = schedule_map[week_day]

      next unless schedule

      start_time = time + schedule.start_offset.minutes

      schedule.appointments_count.times do |ai|
        Appointment.find_or_create_by!(
          specialist: @specialist,
          time: start_time + (ai * schedule.appointment_duration).minutes
        )
      end
    end
  end

  private

  def schedule_map
    @schedule_map ||= @specialist.schedules.index_by { |s| Schedule.week_days[s.week_day] }
  end
end
