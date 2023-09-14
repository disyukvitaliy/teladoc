class Appointment < ApplicationRecord
  belongs_to :specialist
  belongs_to :patient, optional: true

  scope :available, -> { where(patient_id: nil) }

  def available?
    !patient_id?
  end

  alias available available?
end
