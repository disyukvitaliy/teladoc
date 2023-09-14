Appointment.delete_all
Schedule.delete_all
Patient.delete_all
Specialist.delete_all

specialist = Specialist.create!(name: 'Specialist #1')
patient = Patient.create!(name: 'Patient #1')

Schedule.create!(specialist: specialist, week_day: :mon, start_offset: 8 * 60, appointment_duration: 30, appointments_count: 15)
Schedule.create!(specialist: specialist, week_day: :tue, start_offset: 8 * 60, appointment_duration: 30, appointments_count: 15)
Schedule.create!(specialist: specialist, week_day: :wed, start_offset: 8 * 60, appointment_duration: 30, appointments_count: 15)
Schedule.create!(specialist: specialist, week_day: :thu, start_offset: 8 * 60, appointment_duration: 30, appointments_count: 15)
Schedule.create!(specialist: specialist, week_day: :fri, start_offset: 10 * 60, appointment_duration: 30, appointments_count: 10)

AppointmentScheduler.new(specialist).call

Appointment.order('RANDOM()').limit(3).update_all(patient_id: patient.id)