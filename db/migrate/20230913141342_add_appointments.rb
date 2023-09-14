class AddAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.belongs_to :specialist, null: false
      t.belongs_to :patient
      t.timestamp :time, null: false
    end
  end
end
