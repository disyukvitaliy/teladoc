class AddSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.belongs_to :specialist, null: false, index: false
      t.integer :week_day, null: false
      t.integer :start_offset, null: false
      t.integer :appointment_duration, null: false
      t.integer :appointments_count, null: false
      # NOTE: not only for fast search but also for validation reasons
      t.index [:specialist_id, :week_day], unique: true
    end
  end
end
